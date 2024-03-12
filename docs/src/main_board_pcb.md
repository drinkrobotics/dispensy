# Main-Board PCB Layout

This page shows the current version of the PCB layout as SVG graphics.

You can also view the [Main-Board PCB layout as PDF](./plot/dispensy.kicad_pcb.pdf).

## 2D PCB Layout

### Front & Back

<script src="js/svg-pan-zoom.js" charset="UTF-8"></script>
<div style="background-color: white; border: 1px solid black;">
    <embed type="image/svg+xml" src="./plot/dispensy.kicad_pcb.svg/0_both.svg" id="pz_dispensy0" style="width: 100%;"/>
    <script>
        document.getElementById('pz_dispensy0').addEventListener('load', function(){
            svgPanZoom(document.getElementById('pz_dispensy0'), {controlIconsEnabled: true, minZoom: 1.0});
        })
    </script>
</div>

[Direct link to this file](./plot/dispensy.kicad_pcb.svg/0_both.svg).

### Front

<script src="js/svg-pan-zoom.js" charset="UTF-8"></script>
<div style="background-color: white; border: 1px solid black;">
    <embed type="image/svg+xml" src="./plot/dispensy.kicad_pcb.svg/1_front.svg" id="pz_dispensy1" style="width: 100%;"/>
    <script>
        document.getElementById('pz_dispensy1').addEventListener('load', function(){
            svgPanZoom(document.getElementById('pz_dispensy1'), {controlIconsEnabled: true, minZoom: 1.0});
        })
    </script>
</div>

[Direct link to this file](./plot/dispensy.kicad_pcb.svg/1_front.svg).

### Back

<script src="js/svg-pan-zoom.js" charset="UTF-8"></script>
<div style="background-color: white; border: 1px solid black;">
    <embed type="image/svg+xml" src="./plot/dispensy.kicad_pcb.svg/2_back.svg" id="pz_dispensy2" style="width: 100%;"/>
    <script>
        document.getElementById('pz_dispensy2').addEventListener('load', function(){
            svgPanZoom(document.getElementById('pz_dispensy2'), {controlIconsEnabled: true, minZoom: 1.0});
        })
    </script>
</div>

[Direct link to this file](./plot/dispensy.kicad_pcb.svg/2_back.svg).

## 3D PCB Model

<p>Status: "<span id="3d_info">Preparing 3D model...</span>"</p>
<div id="3d_viewer" style="width: 100%; height: 100%; background-color: white; border: 1px solid black;"></div>
<script type="module">
    var view = document.getElementById('3d_viewer');
    view.style.height = (view.clientWidth * 0.707) + "px";
    var info = document.getElementById('3d_info');
    import * as View from './js/modelview.js';
    View.init(view, info);
    const file = './plot/dispensy.3mf';
    var xhttp = new XMLHttpRequest();
    xhttp.responseType = 'arraybuffer';
    xhttp.onload = function() {
        if (this.status != 200) {
            info.textContent = "Download of " + file + " failed: " + this.status + " " + this.statusText;
            return;
        }
        info.textContent = "Downloaded: " + file;
        var file_parts = file.split(".");
        var ext = file_parts.pop().toLowerCase();
        if (ext == "zip") {
            ext = file_parts.pop().toLowerCase();
        }
        info.textContent = "Loaded file with extension: " + ext;
        var model_data = this.response;
        View.view(ext, model_data);
    };
    info.textContent = "Fetching: " + file;
    xhttp.open("GET", file);
    xhttp.send();
</script>

[Direct link to this file](./plot/dispensy.3mf).
