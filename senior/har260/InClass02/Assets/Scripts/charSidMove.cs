using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class charSidMove : MonoBehaviour
{
    public GameObject charSid;
    public Animator animator;
    int trackSpace;
    bool jumped;
    public float speed;

    // Start is called before the first frame update
    void Start()
    {
        charSid = this.gameObject;
        trackSpace = 0;
        speed = 5.0f;
    }

    // Update is called once per frame
    void Update()
    {
        animator.SetBool("walkRight", false);
        animator.SetBool("walkLeft", false);
        var tempPos = charSid.transform.position;
        if (Input.GetKey(KeyCode.D))
        {
            animator.SetBool("walkRight", true);
            tempPos.x += speed * Time.deltaTime;
        }
        else if (Input.GetKey(KeyCode.A))
        {
            animator.SetBool("walkLeft", true);
            tempPos.x -= speed * Time.deltaTime;
        }
        if(Input.GetKey(KeyCode.Space) && !jumped)
        {
            animator.SetBool("isJumping", true);
            tempPos.y += 6.0f * Time.deltaTime;
        }
        charSid.transform.position = tempPos;
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        jumped = false;
        animator.SetBool("isJumping", false);
    }
}
