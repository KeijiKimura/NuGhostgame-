using UnityEngine;
using System.Collections;

public class MouseRay : MonoBehaviour {

    public Transform sphere;

	// Use this for initialization
	void Start () {
	
	}

    // Update is called once per frame
    void Update() {

        Cursor.visible = false;

        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit rayHitInfo = new RaycastHit();



        if (Physics.Raycast(ray, out rayHitInfo, 1000f))
        {
            Debug.Log("Mouse Hit");
            Debug.DrawRay(ray.origin, ray.direction * 1000f, Color.red);
            sphere.position = rayHitInfo.point;

        }
	
	}
}
