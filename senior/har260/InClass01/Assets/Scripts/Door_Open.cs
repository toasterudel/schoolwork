using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Door_Open : MonoBehaviour
{
    public bool door_locked;
    public GameObject keycheck;
    public Sprite door_change;
    public GameObject door_background;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        door_locked = keycheck.GetComponent<Key_Remove>().door_open;
      
    }

    private void OnMouseDown()
    {
        if (door_locked)
        {
            door_background.GetComponent<SpriteRenderer>().sprite = door_change;
        }
        Debug.Log("clicked");
    }
}
