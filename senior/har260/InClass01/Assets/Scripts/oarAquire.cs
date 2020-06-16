using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class oarAquire : MonoBehaviour
{

    public GameObject oar;
    public bool oarAquired;

    // Start is called before the first frame update
    void Start()
    {
        oarAquired = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnMouseDown()
    {
        oar.GetComponent<SpriteRenderer>().enabled = false;
        oarAquired = true;
    }
}
