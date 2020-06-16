using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class lifejacketAquire : MonoBehaviour
{

    public GameObject lifejacket;
    public bool lifejacketAquired;
    // Start is called before the first frame update
    void Start()
    {
        lifejacketAquired = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnMouseDown()
    {
        lifejacket.GetComponent<SpriteRenderer>().enabled = false;
        lifejacketAquired = true;
    }
}
