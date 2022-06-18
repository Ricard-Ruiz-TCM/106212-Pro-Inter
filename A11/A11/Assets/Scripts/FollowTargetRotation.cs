using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowTargetRotation : MonoBehaviour
{
    public Transform mTarget;

    public Vector2 mPeriod;

    void Start()
    {

    }

    void Update()
    {
        float lX = Mathf.Repeat(mTarget.position.x, mPeriod.x);
        float lY = Mathf.Repeat(mTarget.position.z, mPeriod.y);
        lX = (lX / mPeriod.x) * 360.0f;
        lY = (1.0f - (lY / mPeriod.y)) * 360.0f;

        transform.rotation = Quaternion.Euler(lY, lX, 0.0f);
    }
}
