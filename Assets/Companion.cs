using UnityEngine;
using System.Collections;

public class Companion : MonoBehaviour {
    float zAxis = 2f;
    Vector3 mousePosition;

    
    // Use this for initialization
    void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        mousePosition = Camera.main.ScreenToWorldPoint(Input.mousePosition);
        mousePosition.z = zAxis;
        transform.position = mousePosition;
    }
}
