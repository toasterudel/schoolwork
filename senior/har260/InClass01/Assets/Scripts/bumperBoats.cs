using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class bumperBoats : MonoBehaviour
{
    public GameObject background;
    public GameObject comeIn;
    public Sprite img1;
    public Sprite img2;
    public int count;
    // Start is called before the first frame update
    void Start()
    {
        count = 0;
    }

    // Update is called once per frame
    void Update()
    {

    }


    private void OnMouseDown()
    {
        count++;
        if (background.GetComponent<SpriteRenderer>().sprite == img1)
        {
            background.GetComponent<SpriteRenderer>().sprite = img2;
        }
        else
        {
            background.GetComponent<SpriteRenderer>().sprite = img1;
        }

        if(count >= 10)
        {
            comeIn.SetActive(true);
        }

        Debug.Log(count);
    }

}