using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class leifMove : MonoBehaviour
{
    public GameObject charLeif;
    public float speed;

    // Start is called before the first frame update
    void Start()
    {
        charLeif = this.gameObject;
        speed = 5.0f;
    }

    // Update is called once per frame
    void Update()
    {
        var tempPos = charLeif.transform.position;
        if (Input.GetKey(KeyCode.D))
        {
            //animator.SetBool("walkRight", true);
            tempPos.x += speed * Time.deltaTime;
        }
        else if (Input.GetKey(KeyCode.A))
        {
            //animator.SetBool("walkLeft", true);
            tempPos.x -= speed * Time.deltaTime;
        }/*
        if (Input.GetKey(KeyCode.Space) && !jumped)
        {
            animator.SetBool("isJumping", true);
            tempPos.y += 6.0f * Time.deltaTime;
        }*/
        charLeif.transform.position = tempPos;
    }
}
