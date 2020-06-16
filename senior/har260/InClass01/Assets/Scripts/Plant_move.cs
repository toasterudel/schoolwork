using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Plant_move : MonoBehaviour
{

    public GameObject plant_still;
    public GameObject plant_move;
    public GameObject key;

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
        plant_still.SetActive(false);
        plant_move.SetActive(true);
        key.SetActive(true);
    }
}
