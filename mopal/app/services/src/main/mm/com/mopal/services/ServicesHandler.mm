package com.mopal.services;

import com.mopal.model.Persona;

handler PersonaService on_route "/api/persona" {
    "/all" : Persona*, list;
}