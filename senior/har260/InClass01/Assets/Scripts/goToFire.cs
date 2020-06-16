using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class goToFire : MonoBehaviour
{
    public GameObject background;
    public GameObject airbubble;
    public GameObject kayak;
    public Sprite fire;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnMouseDown()
    {
        background.GetComponent<SpriteRenderer>().sprite = fire;
        airbubble.GetComponent<SpriteRenderer>().enabled = false;
        kayak.GetComponent<BoxCollider2D>().enabled = false;
    }
}
