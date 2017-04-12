const vec3 p1 = vec3(0.0, 0.0, 1.0);
const vec3 p2 = vec3(1.0, 0.0, 1.0);
const vec3 p3 = vec3(0.5, 0.7, 1.0);


bool isInTriangle(in vec2 coord) {
    vec3 p = vec3(coord, 1.0);
    vec3 v0 = p3 - p1;
    vec3 v1 = p2 - p1;
    vec3 v2 = p - p1;

    float dot00 = dot(v0, v0);
    float dot01 = dot(v0, v1);
    float dot02 = dot(v0, v2);
    float dot11 = dot(v1, v1);
    float dot12 = dot(v1, v2);

    float inverDeno = 1.0 / (dot00 * dot11 - dot01 * dot01);
    float u = (dot11 * dot02 - dot01 * dot12) * inverDeno;
    if (u < 0.0 || u > 1.0) {
        return false;
    }
    float v = (dot00 * dot12 - dot01 * dot02) * inverDeno;
    if (v <0.0 || v > 1.0) {
        return false;
    }
    return (u + v <= 1.0);
}

const float radius = 50.0;
bool isInRadiu(in vec2 coord) {
    vec2 circleCenter = vec2(0.5 * iResolution.x, radius);
    float distance = length(circleCenter - coord);
    return distance <= radius;
}
// main
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    if (isInRadiu(fragCoord) || isInTriangle(coord)) {
        fragColor = vec4(1.0, 0.0, 0.0, 1.0);
    } else {
        fragColor = vec4(0.0, 1.0, 0.0, 1.0);
    }
}
