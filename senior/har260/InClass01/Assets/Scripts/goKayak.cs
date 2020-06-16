using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class goKayak : MonoBehaviour
{

    public bool oarCollected;
    public bool lifejacketCollected;
    public GameObject kayakSeat;
    public GameObject lifejacket;
    public GameObject oar;
    public GameObject background;
    public GameObject kayak;
    public Sprite newBackground;
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        oarCollected = oar.GetComponent<oarAquire>().oarAquired;
        lifejacketCollected = lifejacket.GetComponent<lifejacketAquire>().lifejacketAquired;
    }

    private void OnMouseDown()
    {
        if (oarCollected && lifejacketCollected)
        {
            background.GetComponent<SpriteRenderer>().sprite = newBackground;
            kayakSeat.GetComponent<BoxCollider2D>().enabled = false;
            kayak.SetActive(true);
            Debug.Log("kayaking");
        }
        else
        {
            Debug.Log("not safe to kayak!");
        }
    }
}
