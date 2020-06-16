using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class personClicked : MonoBehaviour
{

    public GameObject background;
    public GameObject oar;
    public GameObject lifejacket;
    public GameObject person;
    public Sprite docks;
    public GameObject kayakSeat;
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
        background.GetComponent<SpriteRenderer>().sprite = docks;
        person.GetComponent<BoxCollider2D>().enabled = false;
        oar.SetActive(true);
        lifejacket.SetActive(true);
        kayakSeat.SetActive(true);
        Debug.Log("hey");
    }
}
