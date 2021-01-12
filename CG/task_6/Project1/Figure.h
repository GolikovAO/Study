#pragma once
#include "Matrix.h"
#include <vector>


class path {
public:
	std::vector<vec3> vertices; 
	vec3 color; 
	float thickness; 
	path(std::vector<vec3> verts, vec3 col, float thickn) {
		vertices = verts;
		color = col;
		thickness = thickn;
	}
};
class model {
public:
	std::vector<path> figure; 
	mat4 modelM; 
	model(std::vector<path> fig, mat4 mat) {
		figure = fig;
		modelM = mat;
	}
};