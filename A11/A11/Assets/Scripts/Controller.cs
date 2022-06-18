using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Controller : MonoBehaviour
{
    public Transform mTarget;

    public float mMoveSpeed = 5.0f;
    public float mRotateSpeed = 2.0f;

    void Start()
    {

    }

    void Update()
    {
        float lMovementForward = Input.GetAxis("Vertical");
        float lMovementSide = Input.GetAxis("Horizontal");

        Vector3 mMovement = Vector3.forward * lMovementForward + Vector3.right * lMovementSide;
        mMovement.Normalize();

        mTarget.position = mTarget.position + (mMovement * mMoveSpeed * Time.deltaTime);

        mTarget.LookAt(mTarget.position + mMovement);
    }
}
