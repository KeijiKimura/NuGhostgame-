using UnityEngine;
using System.Collections;

public class CickLight : MonoBehaviour {

    public static bool allLights = false;
    public static int lightCount;
    public GameObject Player;
    public GameObject lightObject;

	// Use this for initialization

   
        void Awake()
    {
        lightCount = 0;
        allLights = false;
    }
	
	// Update is called once per frame
	void Update () {
	
            if( lightCount == 3)
        {
            allLights = true;
            Debug.Log("go!");
        }

            if (allLights)
        {
            Player.transform.position += Vector3.right * .05f;
        }
	}
    void OnMouseDown()
    {

        lightObject.SetActive(true);
        lightCount++;
        

    }
}
