package com.mopal.model schema data;


entity Evento described_by descripcion searchable by {descripcion} {
    descripcion        : String;
    tipoEvento         : TipoEvento;
    activo             : Boolean;
    montoSoltero       : Decimal(10, 2), optional;
    montoMatrimonio    : Decimal(10, 2), optional;
    montoNino          : Decimal(10, 2), optional;
    montoNinosDescuento : Decimal(10, 2), optional;
}