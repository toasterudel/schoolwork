using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Key_Remove : MonoBehaviour
{
    public SpriteRenderer key_sprite;
    public BoxCollider2D key_collide;
    public bool door_open;
    // Start is called before the first frame update
    void Start()
    {
        door_open = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnMouseDown()
    {
        key_sprite.enabled = false;
        key_collide.enabled = false;
        door_open = true;

    }
}
