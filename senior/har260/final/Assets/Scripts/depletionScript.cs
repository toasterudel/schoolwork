using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class depletionScript : MonoBehaviour
{

    public int totalTime;
    public int degradeRate;
    public int totalSanity;
    public bool[] sanityThreshold;
    public float cycleSpeed;


    // Start is called before the first frame update
    void Start()
    {
        totalTime = 50;
        degradeRate = 1;
        totalSanity = 100; //hp
        sanityThreshold = new bool[5];
        StartCoroutine(TimeDegrade());
    }

    // Update is called once per frame
    void Update()
    {
        if(totalTime < 40 && sanityThreshold[0] == false)
        {
            totalSanity -= 10;
            sanityThreshold[0] = true;
        }
    }

    IEnumerator TimeDegrade()
    {
        while (totalTime >= 40)
        {
            totalTime -= degradeRate;
            Debug.Log("day1: " + totalTime);
            Debug.Log("sanity: " + totalSanity);
            yield return new WaitForSecondsRealtime(1);
        }
        while(totalTime > 0)
        {
            Debug.Log("day0: " + totalTime);
            Debug.Log("sanity: " + totalSanity);
            yield return new WaitForSecondsRealtime(1);

        }

    }
}
