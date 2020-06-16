using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class shrimpCollide : MonoBehaviour
{
    public AudioSource shrimpSound;
    public AudioClip collectShrimp;
    // Start is called before the first frame update
    void Start()
    {
        shrimpSound = this.gameObject.GetComponent<AudioSource>();
        collectShrimp = shrimpSound.clip;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if(collision.gameObject.tag == "Player")
        {
            this.gameObject.GetComponent<SpriteRenderer>().enabled = false;
            this.gameObject.GetComponent<BoxCollider2D>().enabled = false;
            shrimpSound.PlayOneShot(collectShrimp);
        }
    }
}
