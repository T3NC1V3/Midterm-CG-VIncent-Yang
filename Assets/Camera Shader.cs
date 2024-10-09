using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraShader : MonoBehaviour
{
    public Shader cameraGrading = null; //Post Processing
    public Material m_render;

    void RenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, m_render);
    }

}
