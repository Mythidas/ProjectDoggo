shader_type canvas_item;

uniform float fill_amount : hint_range(0.0, 1.0) = 0.0;   // 0.0 = empty, 1.0 = full
uniform vec4 fill_color : source_color = vec4(0.0, 0.0, 0.0, 0.65);
uniform vec4 bg_color : source_color = vec4(0.0, 0.0, 0.0, 0.25);
uniform bool clockwise = true;
uniform float start_angle : hint_range(0.0, 6.28) = -1.5708; // -PI/2 = top (12 o'clock)

void fragment() {
    vec2 uv = UV - vec2(0.5);                    // center coordinates (-0.5 to +0.5)
    float dist = length(uv);                    // distance from center (0 to ~0.707)
    float max_dist = 0.70710678;                // sqrt(2)/2 = corner distance
    
    // Normalize distance so 1.0 = corners
    float normalized_dist = dist / max_dist;
    
    float angle = atan(uv.y, uv.x);
    if (!clockwise) angle = -angle;
    angle = angle - start_angle;
    angle = fract((angle + PI) / TAU);          // make it 0..1, starting from top
    
    // Fill based on both angle and distance (true radial sweep)
    float fill_threshold = fill_amount;
    
    // Show fill only if we're within the sweep angle AND inside the growing radius
    bool in_angle = angle <= fill_threshold;
    bool in_radius = normalized_dist <= fill_threshold;
    
    // Combine both conditions
    float mask = float(in_angle);
    
    COLOR = mix(bg_color, fill_color, mask);
    
    // Optional: soft edge
    // float edge = 0.01;
    // mask = smoothstep(0.0, edge, mask) * smoothstep(1.0, 1.0-edge, mask);
}