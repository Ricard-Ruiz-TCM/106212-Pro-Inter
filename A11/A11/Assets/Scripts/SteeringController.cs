using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using MoonSharp.Interpreter;
using System;

public class SteeringObject
{
    SteeringController mBase;

    [MoonSharpHidden]
    public SteeringObject(SteeringController aBase)
    {
        mBase = aBase;
    }
    
    public float GetNumberData(string aName)
    {
        return mBase.GetNumberData(aName);
    }

    public string GetStringData(string aName)
    {
        return mBase.GetStringData(aName);
    }

    public Vector2 GetVelocity()
    {
        return mBase.GetVelocity();
    }

    public void SetVelocity(float x, float y)
    {
        mBase.SetVelocity(new Vector2(x, y));
    }

    public Vector2 GetMousePosition()
    {
        Vector3 lPos = mBase.GetMousePosition();
        return new Vector2(lPos.x, lPos.z);
    }

    public Vector2 GetPosition()
    {
        Transform t = mBase.transform;
        return new Vector2(t.transform.position.x, t.transform.position.z);
    }

    public Vector2 GetTarget()
    {
        Transform t = mBase.GetTarget();
        if (t != null)
        {
            return new Vector2(t.transform.position.x, t.transform.position.z);
        }
        else
        {
            return GetPosition();
        }
    }
}

public class SteeringController : MonoBehaviour
{
    private Script mScript;

    private Vector2 mVelocity = Vector2.zero;

    public Transform mTarget;

    private Dictionary<string, float> mNumberData;
    private Dictionary<string, string> mStringData;

    private string mTargetName;

    void Start()
    {

    }

    public void SetBehaviour(string aBehaviour)
    {
        mScript = new Script();
        mScript.Globals["agent"] = this;
        mScript.Globals["print"] = (Action<string>)((msg) => Debug.Log(msg));
        mScript.DoString(aBehaviour);
    }
    
    public void SetNumberData(Dictionary<string, float> aNumberData)
    {
        mNumberData = aNumberData;
    }

    public float GetNumberData(string aName)
    {
        if (mNumberData.ContainsKey(aName))
        {
            return mNumberData[aName];
        }
        return 0.0f;
    }

    public void SetStringData(Dictionary<string, string> aStringData)
    {
        mStringData = aStringData;

        if (mStringData.ContainsKey("target"))
        {
            SetTargetName(mStringData["target"]);
        }
    }

    public string GetStringData(string aName)
    {
        if (mStringData.ContainsKey(aName))
        {
            return mStringData[aName];
        }
        return "";
    }

    public Vector2 GetVelocity()
    {
        return mVelocity;
    }

    public void SetVelocity(Vector2 aVelocity)
    {
        mVelocity = aVelocity;
    }

    public Transform GetTarget()
    {
        return mTarget;
    }
    
    public void SetTargetName(string aName)
    {
        mTargetName = aName;
    }

    public Vector3 GetMousePosition()
    {
        Vector3 mouse = Input.mousePosition;
        Ray castPoint = Camera.main.ScreenPointToRay(mouse);
        RaycastHit hit;
        if (Physics.Raycast(castPoint, out hit, Mathf.Infinity))
        {
            return hit.point;
        }
        return Vector3.zero;
    }

    private void ObtainTarget()
    {
        if (mTarget == null && mTargetName != "")
        {
            GameObject lTarget = GameObject.Find(mTargetName);
            if (lTarget != null)
            {
                mTarget = lTarget.transform;
            }
        }
    }

    void Update()
    {
        ObtainTarget();

        mScript.Call(mScript.Globals["update"]);

        transform.position = transform.position + new Vector3(mVelocity.x, 0.0f, mVelocity.y) * Time.deltaTime;

        transform.LookAt(transform.position + new Vector3(mVelocity.x, 0.0f, mVelocity.y));
    }
}
