var scene, camera, renderer, controls, effect, left_bar, right_bar;

var architecture = [], plotPoints = [];

var points;

var maxIndex = 0;

var instrumentsGroup, filtersGroup;

var criticizeGroup, criticizeData;

var processing;

var actuators = [], intersectsActuator;

var update = false, filter = false;

var separateFilter = '', togetherFilter = '', anyOrbitFilter = '', orbitsFilter = [];

var currentOrbit = 1;

var websocket = false, first = true;

var closet = {x: 0, y: -50, z: 50};

var w_shelf = 300, h_shelf = 10, n_shelf = 5;

var dash1 = {x: 300, y: 0, z: 0};

var dash2 = {x: -300, y: 0, z: 0};

var plot = {x: 0, y: 150, z: 500, w: 700, h: 400};

var xLabel = ["0", "0.05", "0.10", "0.15", "0.20", "0.25", "0.30"],
    yLabel = ["2000", "4000", "6000", "8000"];

function init() {

    // Scene and camera initialization
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(90, window.innerWidth / window.innerHeight, 1, 1000);
    camera.position.set(0,200,0);
    scene.add(camera);

    // Loading Manager initialization
    loadingManager = new THREE.LoadingManager();

    loadingManager.onProgress = function(item, loaded, total) {
        console.log(item, loaded, total);
    };

    loadingManager.onLoad = function() {
        console.log('all items loaded');
        $('#loading').fadeOut();
    };

    loadingManager.onError = function () {
        console.log('there has been an error');
    };

    // Renderer initialization
    container = document.getElementById('viewer');
    renderer = new THREE.WebGLRenderer({alpha: true, antialias: true});
    element = renderer.domElement;
    container.appendChild(element);
    effect = new THREE.StereoEffect(renderer);

    //Control fallback with mouse/touch events initialization
    controls = new THREE.OrbitControls(camera, element);
    controls.target.set(
        camera.position.x + 0.15,
        camera.position.y,
        camera.position.z
    );
    controls.noPan = true;
    controls.noZoom = true;

    //Progress bar initialization
    left_bar = new ProgressBar.Circle('#guide_circle_left', {
        strokeWidth: 10,
        easing: 'easeInOut',
        duration: 5,
        color: 'lime',
        trailWidth: 2,
        svgStyle: null
    });

    right_bar = new ProgressBar.Circle('#guide_circle_right', {
        strokeWidth: 10,
        easing: 'easeInOut',
        duration: 5,
        color: 'lime',
        trailWidth: 2,
        svgStyle: null
    });

    // Ligthning
    scene.add(new THREE.AmbientLight(0x939393));
    var light = new THREE.PointLight(0xffffff, 0.2, 0);
    light.position.y = 500;
    light.castShadow = true;
    scene.add(light);

    // -- Create world -- //

    var mesh, material, texture;
    var loader = new THREE.TextureLoader(loadingManager);

    // Ground plane

    texture = loader.load('img/grass.jpg');
    texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
    texture.repeat.set(50, 50);
    texture.anisotropy = 20;
    material = new THREE.MeshPhongMaterial({color: 0xffffff, specular: 0x111111, map: texture});
    mesh = new THREE.Mesh(new THREE.PlaneBufferGeometry(5000, 5000), material);
    mesh.position.set(0, -100, 0);
    mesh.rotation.x = -Math.PI/2;
    scene.add(mesh);

    // Sky sphere

    material = new THREE.MeshLambertMaterial({color: 0xcce0ff, overdraw: 0.5, side: THREE.BackSide});
    mesh = new THREE.Mesh(new THREE.SphereGeometry(800, 32, 32), material);
    mesh.position.set(0, 0, 0);
    scene.add(mesh);

    // Create orbits closet (Orbit 1, 2, 3, 4, 5)

    mesh = drawCloset();
    mesh.rotation.x = Math.PI/2;
    mesh.position.set(closet.x, closet.y, closet.z);
    scene.add(mesh);

    //Create initial architecture (Instruments AB, C, D, E, F)

    architecture[0] = 'AB';
    architecture[1] = 'C';
    architecture[2] = 'D';
    architecture[3] = 'E';
    architecture[4] = 'F';

    repositionInstruments();

    processing = createGridElement("SERVER WORKING", 4000, 400, 400, 40);
    processing.rotation.y = Math.PI;
    processing.position.set(0,350,400);
    scene.add(processing);
    processing.visible = false;

    mesh = drawDashBoard1();
    mesh.position.set(dash1.x,dash1.y,dash1.z);
    mesh.rotation.y = -Math.PI/2;
    scene.add(mesh);

    mesh = drawDashBoard2();
    mesh.position.set(dash2.x,dash2.y,dash2.z);
    scene.add(mesh);

    mesh = drawPlotGrid();
    mesh.position.set(plot.x,plot.y,plot.z);
    scene.add(mesh);

    // Create critic table

    criticizeData = ["== Call criticize to show warnings"];
    drawCriticTable(0);

    material = new THREE.MeshLambertMaterial({color: 0xff666e});
    mesh = new THREE.Mesh(new THREE.CubeGeometry(50,50,50), material);
    mesh.position.set(200,400,-400);
    mesh.userData.index = 0;
    mesh.userData.type = "button";
    mesh.userData.subtype = "indexCritic";
    actuators.push(mesh);
    scene.add(mesh);
}

function render() {

    requestAnimationFrame(render);

    var width = container.offsetWidth;
    var height = container.offsetHeight;
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
    renderer.setSize(width, height);
    effect.setSize(width, height);

    animate();

    controls.update();
    effect.render(scene, camera);
}

function animate() {

    intersectsActuator = getIntersections(actuators);

    if (intersectsActuator.length > 0) {
        left_bar.set(1);
        right_bar.set(1);
    } else {
        left_bar.set(0.0);
        right_bar.set(0.0);
    }
}

$(document).keypress(function() {
    var object;
    if(intersectsActuator.length > 0) {
        object = intersectsActuator[0].object;
        // If intersects instrument
        if(object.userData.type == "instrument") {
            if(object.userData.orbit != currentOrbit) {
                if(currentOrbit >= 0) {
                    architecture[currentOrbit] += object.userData.name;
                    architecture[object.userData.orbit] =
                        architecture[object.userData.orbit].replace(object.userData.name,'');
                    repositionInstruments();
                    needsUpdate();
                } else if(currentOrbit == -10) {
                    architecture[object.userData.orbit] =
                        architecture[object.userData.orbit].replace(object.userData.name,'');
                    repositionInstruments();
                    needsUpdate();
                }
            }
        // If intersects orbit
        } else if(object.userData.type == "orbit") {
            currentOrbit = object.userData.orbit;
            $(".info_text").text("ORBIT "+(currentOrbit+1));

        // If interects button
        } else if(object.userData.type == "button") {
            if(object.userData.subtype == "addInstrument") {
                if(currentOrbit >= 0 && architecture[currentOrbit].length < 6) {
                    architecture[currentOrbit] += object.userData.name;
                    repositionInstruments();
                    needsUpdate();
                } else if(currentOrbit < 0 && currentOrbit > -10) {
                    orbitsFilter[-currentOrbit-1] += object.userData.name;
                    repositionFilters();
                } else if(currentOrbit == -20) {
                    if(separateFilter.length < 2) {
                        separateFilter += object.userData.name;
                        repositionFilters();
                    }
                } else if(currentOrbit == -30) {
                    if(togetherFilter.length < 2) {
                        togetherFilter += object.userData.name;
                        repositionFilters();
                    }
                } else if(currentOrbit == -40) {
                    anyOrbitFilter += object.userData.name;
                    repositionFilters();
                }
            } else if(object.userData.subtype == "deleteInstrument") {
                currentOrbit = -10;
                $(".info_text").text("DELETE INSTRUMENT");
            } else if(object.userData.subtype == "separateFilter") {
                currentOrbit = -20;
                $(".info_text").text("SEPARATE FILTER");
            } else if(object.userData.subtype == "togetherFilter") {
                currentOrbit = -30;
                $(".info_text").text("TOGETHER FILTER");
            } else if(object.userData.subtype == "orbitFilter") {
                currentOrbit = -object.userData.number;
                $(".info_text").text("ORBIT "+(-currentOrbit)+" FILTER");
            } else if(object.userData.subtype == "anyOrbitFilter") {
                currentOrbit = -40;
                $(".info_text").text("ANY ORBIT FILTER");
            } else if(object.userData.subtype == "applyFilter") {
                if(filter == false) {
                    object.material.color.setHex(0x00ff00);
                    filter = true;
                    scene.remove(points);
                    points = drawPlotPoint(true);
                    points.position.set(plot.x,plot.y,plot.z);
                    scene.add(points);
                } else {
                    object.material.color.setHex(0xffff00);
                    filter = false;
                    scene.remove(points);
                    points = drawPlotPoint(false);
                    points.position.set(plot.x,plot.y,plot.z);
                    scene.add(points);
                }
            } else if(object.userData.subtype == "deleteFilter") {
                separateFilter = '';
                togetherFilter = '';
                for(var i = 0; i < 5; i++) {
                    orbitsFilter[i] = '';
                }
                anyOrbitFilter = '';
                repositionFilters();
            } else if(object.userData.subtype == "update") {
                var msg = {event: "evaluate", architecture: architecture};
                ws_send(msg);
                processing.visible = true;
            } else if(object.userData.subtype == "criticize") {
                console.log("criticize");
                var msg = {event: "criticize"};
                ws_send(msg);
            } else if(object.userData.subtype == "indexCritic") {
                console.log("Button critic");
                console.log(object.userData.index);
                object.userData.index = (object.userData.index+1)%(maxIndex+1);
                drawCriticTable(object.userData.index);
            }
        } else {
            // Do nothing
        }
    }
});

function updatePoint() {

     scene.remove(points);
     points = drawPlotPoint(false);
     points.position.set(plot.x,plot.y,plot.z);
     scene.add(points);

    for(var i = 0; i < actuators.length; i++) {
        if(actuators[i].userData.subtype == "update") {
            actuators.splice(i,1);
        }
    }

    var object = scene.getObjectByName("updateButton");
    scene.remove(object);

    update = false;
}

function needsUpdate() {

    if(update == false) {
        updateButton = createGridElement("UPDATE", 1200, 400, 100, 40);
        updateButton.rotation.y = Math.PI;
        updateButton.position.set(0,150,400);
        updateButton.userData.type = "button";
        updateButton.userData.subtype = "update";
        updateButton.name = "updateButton";
        actuators.push(updateButton);
        scene.add(updateButton);
        update = true;
    }
}

init();
render();

function repositionInstruments() {

    for(var i = 0; i < actuators.length; i++) {
        if(actuators[i].userData.type == "instrument") {
            actuators.splice(i,1);
            i--;
        }
    }

    scene.remove(instrumentsGroup);
    instrumentsGroup = new THREE.Object3D();

    var mesh;

    for(var o in architecture) {
        for(var i = 0; i < architecture[o].length; i++) {
            mesh = drawInstrument(architecture[o][i]);
            mesh.userData.orbit = o;
            mesh.position.x = -i*50+w_shelf/2-50/2;
            mesh.position.y = closet.y;
            mesh.position.z = o*(50+h_shelf)+closet.z+30;
            mesh.rotation.y = Math.PI;
            mesh.userData.type = "instrument";
            actuators.push(mesh);
            instrumentsGroup.add(mesh);
        }
    }
    scene.add(instrumentsGroup);
}

function repositionFilters() {

    var mesh;
    var loader = new THREE.TextureLoader(loadingManager);

    scene.remove(filtersGroup);
    filtersGroup = new THREE.Object3D();

    if(separateFilter.length == 1) {
        mesh = drawInstrument(separateFilter[0]);
        mesh.rotation.y = Math.PI;
        mesh.position.set(-350, -75, 200);
        filtersGroup.add(mesh);
    } else if(separateFilter.length == 2) {
        mesh = drawInstrument(separateFilter[0]);
        mesh.rotation.y = Math.PI;
        mesh.position.set(-300, -75, 200);
        filtersGroup.add(mesh);

        mesh = drawInstrument(separateFilter[1]);
        mesh.rotation.y = Math.PI;
        mesh.position.set(-375, -75, 200);
        filtersGroup.add(mesh);
    }

    if(togetherFilter.length == 1) {
        mesh = drawInstrument(togetherFilter[0]);
        mesh.rotation.y = Math.PI;
        mesh.position.set(-350, -75, 100);
        filtersGroup.add(mesh);
    } else if(togetherFilter.length == 2) {
        mesh = drawInstrument(togetherFilter[0]);
        mesh.rotation.y = Math.PI;
        mesh.position.set(-330, -75, 100);
        filtersGroup.add(mesh);
        mesh = drawInstrument(togetherFilter[1]);
        mesh.rotation.y = Math.PI;
        mesh.position.set(-380, -75, 100);
        filtersGroup.add(mesh);
    }

    for(var o in orbitsFilter) {
        for(var i = 0; i < orbitsFilter[o].length; i++) {
            mesh = drawInstrument(orbitsFilter[o][i]);
            mesh.userData.orbit = o;
            mesh.position.x = -400;
            mesh.position.y = i*50-75;
            mesh.position.z = -o*100;
            mesh.rotation.y = Math.PI;
            filtersGroup.add(mesh);
        }
    }

    for(var i = 0; i < anyOrbitFilter.length; i++) {
        mesh = drawInstrument(anyOrbitFilter[i]);
        mesh.userData.orbit = o;
        mesh.position.x = -290;
        mesh.position.y = -75;
        mesh.position.z = i*50-(175+(anyOrbitFilter.length)*25);
        mesh.rotation.y = Math.PI;
        filtersGroup.add(mesh);
    }

    scene.add(filtersGroup);
}

function setOrientationControls(e) {
    if(!e.alpha) {
        return;
    }
    controls = new THREE.DeviceOrientationControls(camera, true);
    controls.connect();
    controls.update();
    element.addEventListener('click', fullscreen, false);
    window.removeEventListener('deviceorientation', setOrientationControls, true);
}

window.addEventListener('deviceorientation', setOrientationControls, true);

function fullscreen() {
    if (container.requestFullscreen) {
        container.requestFullscreen();
    } else if (container.msRequestFullscreen) {
        container.msRequestFullscreen();
    } else if (container.mozRequestFullScreen) {
        container.mozRequestFullScreen();
    } else if (container.webkitRequestFullscreen) {
        container.webkitRequestFullscreen();
    }
}

// Calculate objects intersecting in the picking ray
function getIntersections(objects) {
    var raycaster = new THREE.Raycaster();
    var vector = new THREE.Vector3( 0, 0, -1);
    vector.applyQuaternion(camera.quaternion);
    raycaster.set(camera.position, vector);
    return raycaster.intersectObjects(objects, true);
}

function drawCloset() {

    var closet = new THREE.Object3D();

    var mesh;

    var material = new THREE.MeshLambertMaterial({color: 0xff666e, transparent: true, opacity: 1}); 

    var h_closet = n_shelf*50+(n_shelf+1)*h_shelf;

    for(var o = 0; o < n_shelf; o++) {
        mesh = new THREE.Mesh(new THREE.CubeGeometry(w_shelf, h_shelf, 50), material);
        mesh.position.set(0, o*(h_shelf+50), 0);
        mesh.userData.instruments = 0;
        mesh.userData.orbit = o;
        mesh.userData.type = "orbit";
        actuators.push(mesh);
        closet.add(mesh);
    }

    mesh = new THREE.Mesh(new THREE.CubeGeometry(h_shelf, h_closet, 50), material);
    mesh.position.set(-(w_shelf+h_shelf)/2, (h_closet-h_shelf)/2, 0);
    closet.add(mesh);

    mesh = new THREE.Mesh(new THREE.CubeGeometry(h_shelf, h_closet, 50), material);
    mesh.position.set((w_shelf+h_shelf)/2, (h_closet-h_shelf)/2, 0);
    closet.add(mesh);

    mesh = new THREE.Mesh(new THREE.CubeGeometry(w_shelf, h_shelf, 50), material);
    mesh.position.set(0, n_shelf*(h_shelf+50), 0);
    closet.add(mesh);

    mesh = new THREE.Mesh(new THREE.CubeGeometry(w_shelf, h_closet, 0), material);
    mesh.position.set(0, (h_closet-h_shelf)/2, 25);
    closet.add(mesh);

    return closet;
}

function drawInstrument(text) {

    var size = 50;

    var canvas = document.createElement('canvas');
    var context = canvas.getContext('2d');
    canvas.width = size; canvas.height = size;
    context.font = "25px Arial";
    var metric = context.measureText(text);
    var text_len_pixels = metric.width;
    context.fillStyle = "white";
    context.fillRect(0, 0, size, size);
    context.fillStyle = "black";
    context.fillText(text, (size-text_len_pixels)/2, size/2+10);
    var texture = new THREE.Texture(canvas);
    texture.needsUpdate = true;
    var material = new THREE.MeshLambertMaterial({map: texture, color: 0x00baff});
    var mesh = new THREE.Mesh(new THREE.CubeGeometry(size, size, size), material);
    mesh.userData.name = text;
    return mesh;
}

function getConfiguration() {

    return architecture;
}

function createGridElement(text, x, y, x1, x2) {

    var texture = new THREEx.DynamicTexture(x,y)
    texture.context.font = "bolder 150px Verdana";
    texture.texture.anisotropy = renderer.getMaxAnisotropy()

    // update the text
    texture.clear("rgba(220,220,0,1)").drawText(text, undefined, 256, 'black');

    var material = new THREE.MeshBasicMaterial({
        map : texture.texture
    })
    var mesh = new THREE.Mesh(new THREE.PlaneGeometry(x1, x2), material);

    return mesh;
}

function selectObject(name, color) {
   var object = scene.getObjectByName(name, true);
   object.material.color = new THREE.Color(color);
}

// ----

// Draw plot grid

function drawPlotGrid() {

    var grid = new THREE.Object3D(),
    width = plot.w/2,
    height = plot.h/2,
    a = xLabel.length,
    b = yLabel.length;

    var gridXY = createAGrid({
                height: width,
                width: height,
                linesHeight: a,
                linesWidth: b,
                color: 0xcccccc
            });

    gridXY.position.z = 0;
    grid.add(gridXY);

    var labelX = labelAxis(width, xLabel,"x");
    labelX.position.x = width - 40;
    labelX.position.y = -height - 40;
    labelX.position.z = 0;
    grid.add(labelX);

    var labelY = labelAxis(height, yLabel,"y");
    labelY.position.x = width+20;
    labelY.position.y = -height + (2*height/a) - 20;
    labelY.position.z = 0;
    grid.add(labelY);

    return grid;
}

function addPlotPoint(science, cost, architecture) {

    var arch = ['','','','',''];

    arch[0] = architecture[0];
    arch[1] = architecture[1];
    arch[2] = architecture[2];
    arch[3] = architecture[3];
    arch[4] = architecture[4];

    plotPoints.push({x: science, y: cost, architecture: arch});
}

function drawPlotPoint(filter) {

    var xmin = -plot.w/2, xmax = plot.w/2;
    var ymin = -plot.h/2, ymax = plot.h/2;

    var points = new THREE.Object3D();
    points.name = "points";

    var mesh, material;

    material = new THREE.MeshBasicMaterial({color: 0xffff00});

    for(var i = 0; i < plotPoints.length - 1; i++) {

        if(evaluatePoint(plotPoints[i]) == true && filter == true) {
            material = new THREE.MeshBasicMaterial({color: 0x622567});
        } else {
            material = new THREE.MeshBasicMaterial({color: 0xffff00});
        }

        mesh = new THREE.Mesh(new THREE.SphereGeometry(5, 4, 4), material);
        mesh.position.x = -(plotPoints[i].x*700)/0.35+350;
        mesh.position.y = (plotPoints[i].y*400)/8000-200;
        mesh.position.z = 10;
        points.add(mesh);
    }

    if(evaluatePoint(plotPoints[i]) == true && filter == true) {
        material = new THREE.MeshBasicMaterial({color: 0x000099});
    } else {
        material = new THREE.MeshBasicMaterial({color: 0xff0000});
    }
    mesh = new THREE.Mesh(new THREE.SphereGeometry(5, 4, 4), material);
    mesh.position.x = -(plotPoints[plotPoints.length - 1].x*700)/0.35+350;
    mesh.position.y = (plotPoints[plotPoints.length - 1].y*400)/8000-200;
    mesh.position.z = 0;
    points.add(mesh);

    return points;
}

function evaluatePoint(pointPlot) {

    var result = true;

    var architecture = pointPlot.architecture;

    for(var o in architecture) {
        // Evaluate separete filter
        if(architecture[o].indexOf(separateFilter[0]) != -1 && architecture[o].indexOf(separateFilter[1]) != -1) {
            result = false;
        }
        // Evaluate together filter
        if((architecture[o].indexOf(togetherFilter[0]) != -1 && architecture[o].indexOf(togetherFilter[1]) == -1) || 
            (architecture[o].indexOf(togetherFilter[0]) == -1 && architecture[o].indexOf(togetherFilter[1]) != -1)) {
            result = false;
        }
        // Evaluate orbits filters
        for(var i = 0; i < orbitsFilter[o].length; i++) {
            if(architecture[o].indexOf(orbitsFilter[o][i]) == -1) {
                result = false;
            }
        }
        // Evaluate any orbit filter
        var present = false;
        if(anyOrbitFilter != '') {
            for(var o in architecture) {
                if(architecture[o].indexOf(anyOrbitFilter[0]) != -1) {
                    present = true;
                }
            }
        } else {
            present = true;
        }

        if(present == false) {
            result = false;
        }
    }

    return result;
}

// Draw dash board

function drawDashBoard1() {

    var mesh;

    var instrumentNames = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];

    var dashBoard = new THREE.Object3D();

    for(i in instrumentNames){
        mesh = drawInstrument(instrumentNames[i]);
        mesh.position.set((i%6)*70-170,-50,Math.floor(i/6)*70-20);
        mesh.userData.name = instrumentNames[i];
        mesh.userData.type = "button";
        mesh.userData.subtype = "addInstrument";
        actuators.push(mesh);
        dashBoard.add(mesh);
    }

    // Create trash container
    var loader = new THREE.TextureLoader(loadingManager);
    var texture = loader.load('img/trash.jpg');
    var material = new THREE.MeshLambertMaterial({map: texture, side:THREE.DoubleSide});
    mesh = new THREE.Mesh(new THREE.CubeGeometry(50, 50, 50), material);
    mesh.position.set(-250, -50, 50);
    mesh.userData.type = "button";
    mesh.userData.subtype = "deleteInstrument";
    actuators.push(mesh);
    dashBoard.add(mesh);

    return dashBoard;
}

function drawDashBoard2() {

    var mesh, material;
    var loader = new THREE.TextureLoader(loadingManager);

    var dashBoard = new THREE.Object3D();

    texture = loader.load('img/on.jpg');
    material = new THREE.MeshLambertMaterial({color: 0xffff00, map: texture});
    mesh = new THREE.Mesh(new THREE.CubeGeometry(50, 50, 50), material);
    mesh.position.set(140, -50, -260);
    mesh.userData.type = "button";
    mesh.userData.subtype = "applyFilter";
    actuators.push(mesh);
    dashBoard.add(mesh);

    texture = loader.load('img/trash.jpg');
    material = new THREE.MeshLambertMaterial({map: texture, side:THREE.DoubleSide});
    mesh = new THREE.Mesh(new THREE.CubeGeometry(50, 50, 50), material);
    mesh.position.set(140, -50, -340);
    mesh.userData.type = "button";
    mesh.userData.subtype = "deleteFilter";
    actuators.push(mesh);
    dashBoard.add(mesh);

    //Create filter base

    var material = new THREE.MeshLambertMaterial({color: 0xff3300});
    mesh = new THREE.Mesh(new THREE.CubeGeometry(200, 1, 80), material);
    mesh.userData.type = "button";
    mesh.userData.subtype = "separateFilter";
    actuators.push(mesh);
    mesh.position.set(-50, -100, 200);
    dashBoard.add(mesh);

    texture = loader.load('img/wall.jpg');
    material = new THREE.MeshLambertMaterial({color: 0xffffff, specular: 0x111111, map: texture});

    mesh = new THREE.Mesh(new THREE.CubeGeometry(20, 60, 70), material);
    mesh.position.set(-40, -70, 200);
    dashBoard.add(mesh);

    var material = new THREE.MeshLambertMaterial({color: 0xffcc00});
    mesh = new THREE.Mesh(new THREE.CubeGeometry(200, 1, 80), material);
    mesh.userData.type = "button";
    mesh.userData.subtype = "togetherFilter";
    actuators.push(mesh);
    mesh.position.set(-50, -100, 100);
    dashBoard.add(mesh);

    texture = loader.load('img/love.jpg');
    material = new THREE.MeshLambertMaterial({color: 0xffffff, specular: 0x111111, map: texture});
    mesh = new THREE.Mesh(new THREE.CubeGeometry(120, 10, 70), material);
    mesh.position.set(-50, -95,100);
    dashBoard.add(mesh);

    //Filter orbits

    for(var f = 0; f < 5; f++) {
        material = new THREE.MeshLambertMaterial({color: 0xff99ff});
        mesh = new THREE.Mesh(new THREE.CubeGeometry(100, 1, 80), material);
        mesh.userData.type = "button";
        mesh.userData.subtype = "orbitFilter";
        mesh.userData.number = (f+1);
        actuators.push(mesh);
        mesh.position.set(-100, -100, -f*100);
        dashBoard.add(mesh);
        orbitsFilter[f] = '';
    }

    material = new THREE.MeshLambertMaterial({color: 0xff99ff});
    mesh = new THREE.Mesh(new THREE.CubeGeometry(80, 1, 480), material);
    mesh.userData.type = "button";
    mesh.userData.subtype = "anyOrbitFilter";
    actuators.push(mesh);
    mesh.position.set(10, -100, -200);
    dashBoard.add(mesh);
    orbitsFilter[f] = '';

    return dashBoard;
}

// ------- Plot functions

function makeTextSprite( message, parameters ) {
    if ( parameters === undefined ) parameters = {};

    var fontface = parameters["fontface"] || "Helvetica";
    var fontsize = parameters["fontsize"] || 70;
    var canvas = document.createElement('canvas');
    var context = canvas.getContext('2d');
    context.font = fontsize + "px " + fontface;

    // get size data (height depends only on font size)
    var metrics = context.measureText( message );
    var textWidth = metrics.width;


    // text color
    context.fillStyle = "rgba(0, 0, 0, 1.0)";
    context.fillText(message, 0, fontsize);

    // canvas contents will be used for a texture
    var texture = new THREE.Texture(canvas)
            texture.minFilter = THREE.LinearFilter;
            texture.needsUpdate = true;

    var spriteMaterial = new THREE.SpriteMaterial({ map: texture, useScreenCoordinates: false});
    var sprite = new THREE.Sprite(spriteMaterial);
    sprite.scale.set(100,50,1.0);
    return sprite;
}

function createAGrid(opts) {
        var config = opts || {
            height: 500,
            width: 500,
            linesHeight: 10,
            linesWidth: 10,
            color: 0xDD006C
        };

        var material = new THREE.LineBasicMaterial({
            color: config.color,
            opacity: 0.2
        });

        var gridObject = new THREE.Object3D(),
                gridGeo= new THREE.Geometry(),
                stepw = 2*config.width/config.linesWidth,
                steph = 2*config.height/config.linesHeight;

        //width
        for(var i = - config.width; i <= config.width; i += stepw) {
                gridGeo.vertices.push(new THREE.Vector3(-config.height, i,0));
                gridGeo.vertices.push(new THREE.Vector3(config.height, i,0));

        }
        //height
        for(var i = - config.height; i <= config.height; i += steph) {
                gridGeo.vertices.push(new THREE.Vector3(i,- config.width,0 ));
                gridGeo.vertices.push(new THREE.Vector3(i, config.width, 0 ));
        }

        var line = new THREE.Line(gridGeo, material, THREE.LinePieces);
        gridObject.add(line);

        return gridObject;
}

function labelAxis(width, data, direction) {

  var separator = 2*width/data.length,
            p = {
                x:0, y:0, z:0
            },
            dobj = new THREE.Object3D();

  for ( var i = 0; i < data.length; i ++ ) {
        var label = makeTextSprite(data[i]);

        label.position.set(p.x,p.y,p.z);

        dobj.add( label );
        if (direction=="y"){
            p[direction]+=separator;
        }else{
            p[direction]-=separator;
        }
  }
  return dobj;
}

function cubeGeometry2LineGeometry(input) {
    var geometry = new THREE.Geometry();
    var vertices = geometry.vertices;
    for (var i = 0; i < input.faces.length; i += 2) {
        var face1 = input.faces[i];
        var face2 = input.faces[i + 1];
        var c1 = input.vertices[face1.c].clone();
        var a1 = input.vertices[face1.a].clone();
        var a2 = input.vertices[face2.a].clone();
        var b2 = input.vertices[face2.b].clone();
        var c2 = input.vertices[face2.c].clone();
        vertices.push(c1, a1, a2, b2, b2, c2);
    }
    geometry.computeLineDistances();
    return geometry;
}

function drawCriticTable(index) {
    var mesh;
    var data = criticizeData;
    scene.remove(criticizeGroup);
    criticizeGroup = new THREE.Object3D();

    maxIndex = Math.floor(data.length/5);
    console.log(maxIndex);

    var i_min = index*5;
    var i_max = (data.length < (index+1)*5) ? data.length : (index+1)*5;

    for(var i = i_min; i < i_max ; i++) {
        var color = "blue";
        if(data[i].includes("==")) {
            color = "orange";
        } else if(data[i].includes(">>")) {
            color = "red";
        } else if(data[i].includes("<<")) {
            color = "green";
        }
        mesh = drawCriticRow(data[i],color);
        mesh.position.set(-375,300-(i-i_min)*50,-400);
        criticizeGroup.add(mesh);
    }

    scene.add(criticizeGroup);
}

function drawCriticRow(text, color) {

    var geometry, material, mesh, fontshape;

    var tableRow = new THREE.Object3D();

    var area_size = {x:750, y:50, z:10};

    // wLabel
    var dynamicTexture = new THREEx.DynamicTexture(area_size.x*5,area_size.y*5);
    dynamicTexture.context.font = "bolder 100px Verdana";
    dynamicTexture.texture.anisotropy = renderer.getMaxAnisotropy()
    dynamicTexture.clear(color).drawTextCooked({text: text, margin: 0.05, lineHeight: 0.6});
    geometry = new THREE.PlaneGeometry(area_size.x,area_size.y);
    material = new THREE.MeshBasicMaterial({map:dynamicTexture.texture});
    mesh = new THREE.Mesh(geometry, material);
    mesh.position.set(area_size.x/2,-area_size.y/2,area_size.z+0.1);
    tableRow.add(mesh);

    // wValueTextField
    geometry = new THREE.BoxGeometry(area_size.x, area_size.y, area_size.z);
    material = new THREE.MeshBasicMaterial();
    mesh = new THREE.Mesh(geometry, material);
    mesh.material.color.setHex("0x303030");
    mesh.position.set(area_size.x/2,-area_size.y/2,area_size.z/2);
    tableRow.add(mesh);

    // wMarker
    geometry = new THREE.BoxGeometry(20+0.1, area_size.y+0.1, area_size.z);
    material = new THREE.MeshBasicMaterial();
    mesh = new THREE.Mesh(geometry, material);
    mesh.material.color.setHex("0x303030");
    mesh.position.set(20/2,-area_size.y/2,area_size.z/2+5);
    tableRow.add(mesh);

    // wFrame
    geometry = cubeGeometry2LineGeometry(
        new THREE.BoxGeometry(area_size.x, area_size.y, 0.1));
    material = new THREE.LineBasicMaterial();
    mesh = new THREE.Line(geometry, material);
    mesh.material.color.setHex("0x060606");
    mesh.position.set(area_size.x/2,-area_size.y/2,area_size.z+0.1);
    tableRow.add(mesh);

    return tableRow;
}

// ----- Web sockets

$(document).ready(function () {
    if("WebSocket" in window){
        websocket = true;
    }else{
        // no web socket support
        websocket = false;
    }
    if(first == true) {
        var msg = {event: 'register'};
        ws_send(msg);
    }
});


function ws_send(msg){
    if( websocket == true ){
        if(typeof(ws) == 'undefined' || ws.readyState === undefined || ws.readyState > 1){
            open_ws(msg);
        }else{
            ws.send( JSON.stringify(msg) );
            console.log("ws_send sent");
        }
    }
}

function open_ws(msg){
    if(typeof(ws) == 'undefined' || ws.readyState === undefined || ws.readyState > 1){
        ws = new WebSocket("ws://13.58.68.155/websocket");
        ws.onopen = function(){
            console.log("ws open");
            if( msg.length != 0 ){
                ws_send(msg);
            }
        }

        ws.onmessage = function (evt){
            var received_msg = evt.data;
            msg = JSON.parse(evt.data)
            science = msg.science;
            cost = msg.cost;
            if(msg.type == "init"){
                architecture = msg.architecture;
                addPlotPoint(science,cost,architecture);
            } else if(msg.type == "done") {
                repositionInstruments();
                updatePoint();
                first = false;
            } else if(msg.type == "requestCriticize") {
                var msg = {"event": "responseCriticize", "architecture": architecture};
                ws_send(msg);
                processing.visible = true;
            } else if(msg.type == "criticize") {
                criticizeData = msg.data;
                drawCriticTable(0);
                processing.visible = false;
            } else if(msg.type == "assistant") {
                console.log("assistant message received");
            } else {
                addPlotPoint(science,cost,architecture);
                updatePoint();
                processing.visible = false;
            }
        }

        ws.onclose = function(){
            console.log("Connection is closed... reopen");
            if(first == true) {
                var msg = { event: 'register'};
            } else {
                var msg = {event: ''};
            }
            setTimeout( function(){ws_send(msg);}, 1000);
        }
    }
}
