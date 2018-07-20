package com.mopal.model;

import com.mopal.model.g.EncuentroBase;
import tekgenesis.authorization.User;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.core.DateOnly;
import tekgenesis.common.core.Option;
import tekgenesis.persistence.Criteria;

import static com.mopal.model.g.ComunidadPastorTable.COMUNIDAD_PASTOR;
import static com.mopal.model.g.ComunidadTable.COMUNIDAD;
import static com.mopal.model.g.EncuentroTable.ENCUENTRO;
import static com.mopal.model.g.UsuarioAsistenteTable.USUARIO_ASISTENTE;

/** User class for Model: Encuentro */
public class Encuentro extends EncuentroBase {
    public static ImmutableList<Encuentro> listAllByUser(final User user, final Option<Nivel> nivel, final Option<Comunidad> comunidad, final Option<DateOnly> fechaDesde, final Option<DateOnly> fechaHasta) {
        if(user.getId().equals("admin")) {
            return list().toList();
        } else {
            final Criteria nivelCriteria = nivel.isPresent() ? COMUNIDAD.NIVEL_COMUNIDAD_ID.eq(nivel.get().getId()) : Criteria.EMPTY;
            final Criteria comunidadCriteria = comunidad.isPresent() ? COMUNIDAD.ID.eq(comunidad.get().getId()) : Criteria.EMPTY;
            Criteria fechaEncuentroCriteria = Criteria.EMPTY;

            if(fechaDesde.isPresent())
                fechaEncuentroCriteria = fechaEncuentroCriteria.and(ENCUENTRO.FECHA_ENCUENTRO.gt(fechaDesde.get()));

            if(fechaHasta.isPresent())
                fechaEncuentroCriteria = fechaEncuentroCriteria.and(ENCUENTRO.FECHA_ENCUENTRO.lt(fechaHasta.get()));

            final Criteria criteria = nivelCriteria.and(comunidadCriteria).and(fechaEncuentroCriteria);

            return list()
                    .join(COMUNIDAD_PASTOR, COMUNIDAD_PASTOR.COMUNIDAD_ID.eq(ENCUENTRO.COMUNIDAD_ID))
                    .join(COMUNIDAD, COMUNIDAD.ID.eq(COMUNIDAD_PASTOR.COMUNIDAD_ID))
                    .join(USUARIO_ASISTENTE, USUARIO_ASISTENTE.ASISTENTE_ID.eq(COMUNIDAD_PASTOR.PASTOR_ID))
                    .where(USUARIO_ASISTENTE.USUARIO_ID.eq(user.getId()).and(criteria)).toList();
        }
    }
}
