using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class keyAquire : MonoBehaviour
{

    public GameObject key01;
    public bool keyCollected;
    
    // Start is called before the first frame update
    void Start()
    {
        keyCollected = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnMouseDown()
    {
        key01.GetComponent<SpriteRenderer>().enabled = false;
        keyCollected = true;
    }

}
