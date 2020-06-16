<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="2.18.2" minimumScale="inf" maximumScale="1e+08" hasScaleBasedVisibilityFlag="0">
  <pipe>
    <rasterrenderer opacity="1" alphaBand="0" classificationMax="9" classificationMinMaxOrigin="MinMaxFullExtentEstimated" band="1" classificationMin="0" type="singlebandpseudocolor">
      <rasterTransparency/>
      <rastershader>
        <colorrampshader colorRampType="INTERPOLATED" clip="0">
          <item alpha="255" value="0" label="No Data" color="#ffffff"/>
          <item alpha="255" value="1" label="Bare Ground" color="#ffff66"/>
          <item alpha="255" value="2" label="Built-Up Area" color="#ff0000"/>
          <item alpha="255" value="3" label="Forest" color="#246a24"/>
          <item alpha="255" value="4" label="Mangrove" color="#6666ff"/>
          <item alpha="255" value="5" label="Oil Palm" color="#ff8000"/>
          <item alpha="255" value="6" label="Rice Paddy" color="#a65400"/>
          <item alpha="255" value="7" label="Rubber" color="#ff00ff"/>
          <item alpha="255" value="8" label="Shrub/Orchard" color="#ccff66"/>
          <item alpha="255" value="9" label="Water" color="#66ccff"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0"/>
    <huesaturation colorizeGreen="128" colorizeOn="0" colorizeRed="255" colorizeBlue="128" grayscaleMode="0" saturation="0" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
