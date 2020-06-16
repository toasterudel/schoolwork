using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class doorClicked : MonoBehaviour
{

    public bool keyCollected;
    public GameObject keyObj;
    public GameObject doorObj;
    public Sprite newDoorImg;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        keyCollected = keyObj.GetComponent<keyAquire>().keyCollected;
    }

    private void OnMouseDown()
    {
        if (keyCollected)
        {
            doorObj.GetComponent<SpriteRenderer>().sprite = newDoorImg;
            Debug.Log("unlocked");
        }
        else
        {
            Debug.Log("locked");
        }
    }
}
