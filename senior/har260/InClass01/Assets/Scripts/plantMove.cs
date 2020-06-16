using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class plantMove : MonoBehaviour
{
    public GameObject Planter01;
    public GameObject Planter02;
    public GameObject key01;

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
        Planter01.SetActive(false);
        Planter02.SetActive(true);
        key01.SetActive(true);
    }


}
