using UnityEngine;
using System.Collections;

public class moveScreen : MonoBehaviour
{
    public Transform target;
    public float speed;

    void Update()
    {
        if(ClickKeyTree.haveKey)
        {
            MovetheScreen();

        }


    }
    void MovetheScreen()
    {
        float step = speed * Time.deltaTime;
        transform.position = Vector3.MoveTowards(transform.position, target.position, step);
    }
}