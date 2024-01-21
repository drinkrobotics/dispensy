# Main-Board PCB Layout

This page shows the current version of the PCB layout as SVG graphics.

You can also view the [Main-Board PCB layout as PDF](./plot/dispensy_pcb.pdf).

## 2D PCB Layout

<script src="js/svg-pan-zoom.js" charset="UTF-8"></script>
<div style="background-color: white;">
    <embed type="image/svg+xml" src="./plot/dispensy_pcb.svg" id="pz_dispensy" style="width: 100%;"/>
    <script>
        document.getElementById('pz_dispensy').addEventListener('load', function(){
            svgPanZoom(document.getElementById('pz_dispensy'), {controlIconsEnabled: true});
        })
    </script>
</div>

[Direct link to this file](./plot/dispensy_pcb.svg).

## 3D PCB Model

<p>Status: "<span id="3d_info">Preparing 3D model...</span>"</p>
<div id="3d_viewer" style="width: 100%; height: 100%;"></div>
<script type="module">
    var view = document.getElementById('3d_viewer');
    view.style.height = (view.clientWidth * 0.707) + "px";
    var info = document.getElementById('3d_info');
    import * as View from './js/modelview.js';
    View.init(view, info);
    const file = './plot/dispensy_pcb.3mf';
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

[Direct link to this file](./plot/dispensy_pcb.3mf).
