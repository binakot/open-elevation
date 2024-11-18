#!/usr/bin/env bash
set -eu

wget -nc https://srtm.csi.cgiar.org/wp-content/uploads/files/250m/SRTM_NE_250m_TIF.rar
wget -nc https://srtm.csi.cgiar.org/wp-content/uploads/files/250m/SRTM_SE_250m_TIF.rar
wget -nc https://srtm.csi.cgiar.org/wp-content/uploads/files/250m/SRTM_W_250m_TIF.rar

unar -D -s SRTM_NE_250m_TIF.rar
unar -D -s SRTM_SE_250m_TIF.rar
unar -D -s SRTM_W_250m_TIF.rar
