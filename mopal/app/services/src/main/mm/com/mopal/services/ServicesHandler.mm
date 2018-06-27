package com.mopal.services;

import com.mopal.model.Asistente;

handler AsistenteService on_route "/api/asistente" {
    "/all" : Asistente*, list;
}