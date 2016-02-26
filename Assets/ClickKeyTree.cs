using UnityEngine;
using System.Collections;

public class ClickKeyTree : MonoBehaviour {

    static public bool haveKey;
    public GameObject key;

	// Use this for initialization
	void Awake () {

        haveKey = false;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
    void OnMouseDown()
    {

        key.SetActive(false);
        haveKey = true;
        Debug.Log("haveKey");


    }
}
