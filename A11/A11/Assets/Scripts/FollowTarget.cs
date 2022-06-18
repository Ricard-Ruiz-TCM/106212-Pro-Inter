using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowTarget : MonoBehaviour
{
    public Transform mTarget;

    public Vector3 mOffset;

    public float mSpeed = 5.0f;

    void Start()
    {
        GetTarget();
    }

    public void SetTarget(Transform aTarget)
    {
        mTarget = aTarget;
    }

    public void SetDistance(float aDistance)
    {
        mOffset.y = aDistance;
    }

    public bool GetTarget()
    {
        if (mTarget == null)
        {
            SteeringController sc = FindObjectOfType<SteeringController>();
            mTarget = (sc == null) ? null : sc.transform;
        }

        return mTarget != null;
    }

    void Update()
    {
        if (GetTarget())
        {
            transform.position = Vector3.Lerp(transform.position, mTarget.position + mOffset, mSpeed * Time.deltaTime);
        }
    }
}
