using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using MoonSharp.Interpreter;
using System.Linq;
using System.IO;

public class Manager
{
    GameManager mBase;

    [MoonSharpHidden]
    public Manager(GameManager aBase)
    {
        mBase = aBase;
    }

    public void CreateSpaceShip(string aName, string aBehaviour, float aX, float aY, DynValue aNumberData, DynValue aStringData)
    {
        Dictionary<string, float> lNumberData = new Dictionary<string, float>();
        foreach (DynValue lKey in aNumberData.Table.Keys)
        {
            lNumberData.Add(lKey.String, (float)aNumberData.Table.Get(lKey.String).Number);
        }
        Dictionary<string, string> lStringData = new Dictionary<string, string>();
        foreach (DynValue lKey in aStringData.Table.Keys)
        {
            lStringData.Add(lKey.String, aStringData.Table.Get(lKey.String).String);
        }
        mBase.CreateSpaceShip(aName, aBehaviour + ".lua", aX, aY, lNumberData, lStringData);
    }

    public void SetFollowCamera(string aName)
    {
        mBase.SetFollowCamera(aName);
    }

    public void SetCameraDistance(float aDistance)
    {
        mBase.SetCameraDistance(aDistance);
    }
}

public class GameManager : MonoBehaviour
{
    public GameObject mSpaceShipPrefab;
    public GameObject mTargetPrefab;

    public FollowTarget mCamera;

    Dictionary<string, string> mScripts;
    Dictionary<string, Transform> mSpaceShips;

    void Start()
    {
        mSpaceShips = new Dictionary<string, Transform>();

        LuaCustomConverters.RegisterAll();

        //Register the proxy
        UserData.RegisterProxyType<Manager, GameManager>(r => new Manager(r));
        UserData.RegisterProxyType<SteeringObject, SteeringController>(r => new SteeringObject(r));

        //Load the scripts
        mScripts = new Dictionary<string, string>();

        object[] result = Resources.LoadAll("Lua", typeof(TextAsset));

        DirectoryInfo d = new DirectoryInfo(Application.streamingAssetsPath + "/Lua");
        FileInfo[] Files = d.GetFiles("*.lua");
        foreach (FileInfo file in Files)
        {
            mScripts.Add(file.Name, File.ReadAllText(file.FullName));
        }

        Script.DefaultOptions.ScriptLoader = new MoonSharp.Interpreter.Loaders.UnityAssetsScriptLoader(mScripts)
        {
            ModulePaths = new string[] { "?.lua" }
        };

        if (mScripts.ContainsKey("manager.lua"))
        {
            Script lScript = new Script();
            lScript.Globals["manager"] = this;
            lScript.DoString(mScripts["manager.lua"]);
        }
    }

    public void CreateSpaceShip(string aName, string aBehaviour, float aX, float aY, Dictionary<string, float> aNumberData, Dictionary<string, string> aStringData)
    {
        SteeringController lSc = Instantiate(mSpaceShipPrefab, new Vector3(aX, 0.0f, aY), Quaternion.identity).GetComponent<SteeringController>();

        lSc.gameObject.name = aName;
        lSc.SetBehaviour(mScripts[aBehaviour]);
        lSc.SetNumberData(aNumberData);
        lSc.SetStringData(aStringData);

        mSpaceShips.Add(aName, lSc.transform);
    }

    private Transform GetSpaceShip(string aName)
    {
        if (mSpaceShips.ContainsKey(aName))
        {
            return mSpaceShips[aName];
        }
        return null;
    }

    public void SetFollowCamera(string aName)
    {
        Transform lSpaceShip = GetSpaceShip(aName);
        if (lSpaceShip != null)
        {
            mCamera.SetTarget(lSpaceShip);
        }
    }

    public void SetCameraDistance(float aDistance)
    {
        mCamera.SetDistance(aDistance);
    }
}
