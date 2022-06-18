
using System;
using System.IO;
using System.Collections.Generic;

using UnityEngine;

using MoonSharp.Interpreter;

// Clase Proxy para Player, utilizando MoonSharp
public class PlayerProxy {
    
    PlayerScript mPlayer;

    [MoonSharpHidden]
    public PlayerProxy(PlayerScript player){
        this.mPlayer = player;
    }

    // Gets y Sets declarados en el PlayerScripts y reDeclarados aquí para ser utilizados en Lua
    public Vector2 GetPosition(){ return this.mPlayer.GetPosition(); }
    public void SetPosition(float x, float y){ this.mPlayer.SetPosition(new Vector3(x, y)); }
    public float GetSpeed(){ return this.mPlayer.GetSpeed(); }
    public Vector2 GetLimits(){ return this.mPlayer.GetLimits(); }
    public Vector2 GetForward(){ return this.mPlayer.GetForward(); }
    public void SetForward(float x, float y){ this.mPlayer.SetForward(new Vector2(x, y)); }

}

public class PlayerScript : MonoBehaviour {

    // Script de Lua con el que se trabajar
    private Script mScript;

    // Variables del player
    private float mSpeed;
    private Vector2 mForward;

    void Start () {

        // Aplicamos conversores custom (pillados de la A11)
        RegisterConverters();

        // Registramos el proxy para el Player y su comunicaicón con Lua
        RegisterProxy();

        // Cargamos todos los ficheros Lua de "StreamingAssets"
        LoadLua();
        
        // Iniciamos algunos valores base del player
        this.mSpeed = 0.5f;

        this.mForward = new Vector2(0.0f, 0.0f);

        InvokeRepeating("ChangeDirection", 1.0f, 1.0f);
        
    }

    void Update () {
        this.mScript.Call(mScript.Globals["update"], Time.deltaTime);
	}

    // Get & Set de la posición del player
    public Vector2 GetPosition(){ return new Vector2(this.transform.position.x, this.transform.position.y); }
    public void SetPosition(Vector3 pos){ this.transform.position = pos; }

    // Get de la velocidad
    public float GetSpeed(){ return this.mSpeed; }

    // Get de los limites del escenario (Valores así un poco feos, pero bueno, es el trozito de gris claro del gameobject background)
    public Vector2 GetLimits(){ return new Vector2(2.0f, 1.5f); }

    // Get & Set del vector Forward para el movimiento
    public Vector2 GetForward(){ return this.mForward; }
    public void SetForward(Vector2 forward){ this.mForward = forward; }

    // Método para cambiar de dirección de forma aleatoria
    public void ChangeDirection(){
        this.mScript.Call(mScript.Globals["changeDirection"]);
    }

    // Método para cargar todos los ficheros de Lua
    private void LoadLua(){
        Dictionary<string, string> mScripts = new Dictionary<string, string>();

        DirectoryInfo d = new DirectoryInfo(Application.streamingAssetsPath);
        FileInfo[] Files = d.GetFiles("*.lua");
        foreach (FileInfo file in Files)
        {
            mScripts.Add(file.Name, File.ReadAllText(file.FullName));
        }

        Script.DefaultOptions.ScriptLoader = new MoonSharp.Interpreter.Loaders.UnityAssetsScriptLoader(mScripts)
        {
            ModulePaths = new string[] { "?.lua" }
        };

        if (mScripts.ContainsKey("player.lua")){
            mScript = new Script();
            mScript.Globals["player"] = this;
            // Abilitamos el método print de Lua en Unity
            mScript.Globals["print"] = (Action<string>)((msg) => Debug.Log(msg));
            mScript.DoString(mScripts["player.lua"]);
        }

    }

    // Método para registar los LuaCustomConverters
    private void RegisterConverters(){
        LuaCustomConverters.RegisterAll();
    }

    // Método para registar el Proxy entre PlayerPorxy y PlayerScript y conseguir la comunicaicón con Lua
    private void RegisterProxy(){
        UserData.RegisterProxyType<PlayerProxy, PlayerScript>(r => new PlayerProxy(r));
    }

}
