package com.mopal.view;

import com.mopal.model.PRJornadaMaria;
import com.mopal.model.g.AsistenteJornadaMariaTable;
import tekgenesis.common.core.Option;
import tekgenesis.form.Action;
import com.mopal.model.AsistenteJornadaMaria;
import org.jetbrains.annotations.NotNull;
import tekgenesis.transaction.Transaction;

import javax.transaction.TransactionManager;
import java.math.BigDecimal;

import static com.mopal.model.g.AsistenteJornadaMariaBase.findWhere;
import static com.mopal.model.g.AsistenteJornadaMariaTable.ASISTENTE_JORNADA_MARIA;
import static java.math.BigDecimal.ZERO;
import static tekgenesis.common.core.DateOnly.current;
import static tekgenesis.common.core.Option.none;
import static tekgenesis.common.core.Option.option;

/** User class for form: AsistenteJornadaMariaForm */
public class AsistenteJornadaMariaForm extends AsistenteJornadaMariaFormBase {
    //~ Methods ..................................................................................................................

    /** Invoked when creating a form instance */
    @Override @NotNull public Action create() {
        final AsistenteJornadaMaria asistenteJornadaMaria = AsistenteJornadaMaria.create();
        asistenteJornadaMaria.setEvento(getEvento());
        asistenteJornadaMaria.setPersona(getPersona());
        asistenteJornadaMaria.setObservaciones(getObservaciones());

        if(getPersonaMatrimonio() == null) {
            if(!getMontoSugerido().equals(getMontoContribucion()) || getMontoContribucion().equals(ZERO)) {
                asistenteJornadaMaria.setMontoContribucion(getMontoContribucion());
            } else {
                asistenteJornadaMaria.setMontoContribucion(getEvento().getMontoSoltero().add(BigDecimal.valueOf(calcularMontoHijos())));
            }

            asistenteJornadaMaria.insert();
            asociarPersonasACargo(asistenteJornadaMaria, none());
        } else {
            double montoContribucion = 0;

            if(!getMontoSugerido().equals(getMontoContribucion()) || getMontoContribucion().equals(ZERO)) {
                montoContribucion = getMontoContribucion().divide(BigDecimal.valueOf(2)).doubleValue();
            } else {
                montoContribucion = getEvento().getMontoMatrimonio().add(BigDecimal.valueOf(calcularMontoHijos())).divide(BigDecimal.valueOf(2)).doubleValue();
            }

            asistenteJornadaMaria.setMontoContribucion(BigDecimal.valueOf(montoContribucion));

            final AsistenteJornadaMaria asistenteJornadaMariaEsposo = AsistenteJornadaMaria.create();
            asistenteJornadaMariaEsposo.setEvento(getEvento());
            asistenteJornadaMariaEsposo.setPersona(getPersonaMatrimonio());
            asistenteJornadaMariaEsposo.setObservaciones(getObservaciones() == null ? "" : getObservaciones().trim() + " Registrado/a por: " + getPersona().getNombre() + " " + getPersona().getApellido());
            asistenteJornadaMariaEsposo.setMontoContribucion(BigDecimal.valueOf(montoContribucion));

            asistenteJornadaMaria.insert();
            asistenteJornadaMariaEsposo.insert();
            asociarPersonasACargo(asistenteJornadaMaria, option(asistenteJornadaMariaEsposo));
        }

        return actions().getDefault();
    }

    private AsistenteJornadaMaria buscarAsistente(final Integer eventoId, final Integer personaId) {
        return findWhere(ASISTENTE_JORNADA_MARIA.EVENTO_ID.eq(eventoId).and(ASISTENTE_JORNADA_MARIA.PERSONA_ID.eq(personaId)));
    }

    private void asociarPersonasACargo(final AsistenteJornadaMaria asistenteJornadaMaria, final Option<AsistenteJornadaMaria> asistenteJornadaMaria2) {
        final AsistenteJornadaMaria asistenteJornadaMariaDB = buscarAsistente(asistenteJornadaMaria.getEventoId(), asistenteJornadaMaria.getPersonaId());
        final AsistenteJornadaMaria asistenteJornadaMaria2DB = asistenteJornadaMaria2.isPresent() ? buscarAsistente(asistenteJornadaMaria2.get().getEventoId(), asistenteJornadaMaria2.get().getPersonaId()) : null;

        if(getPersonasAsignadas().size() > 0) {
            getPersonasAsignadas().forEach(item -> {
                Transaction.runInTransaction(f -> {
                    final PRJornadaMaria personaRelacionadaJornadaMaria = PRJornadaMaria.create();

                    personaRelacionadaJornadaMaria.setPersonaRelacionada(asistenteJornadaMariaDB);
                    personaRelacionadaJornadaMaria.setPersonaRelacionada2(asistenteJornadaMaria2DB);
                    personaRelacionadaJornadaMaria.setNombre(item.getNombre());
                    personaRelacionadaJornadaMaria.setApellido(item.getApellido());
                    personaRelacionadaJornadaMaria.setFechaNacimiento(item.getFechaNacimiento());
                    personaRelacionadaJornadaMaria.setGrupoReferencia(item.getGrupoReferencia());
                    personaRelacionadaJornadaMaria.setObservaciones(item.getObservacionesPersona());

                    personaRelacionadaJornadaMaria.insert();
                });
            });
        }
    }

    @NotNull
    @Override
    public Action update() {
        return super.update();
    }

    /** Invoked to find an entity instance */
    @Override @NotNull public AsistenteJornadaMaria find() {
        final AsistenteJornadaMaria asistenteJornadaMaria = AsistenteJornadaMaria.find(getId());
        asistenteJornadaMaria.getPersonasRelacionadas().forEach(personaAsignada -> {
            final PersonasAsignadasRow personasAsignadasRow = getPersonasAsignadas().add();

            personasAsignadasRow.setIdPersonaAsignada(personaAsignada.getId());
            personasAsignadasRow.setNombre(personaAsignada.getNombre());
            personasAsignadasRow.setApellido(personaAsignada.getApellido());
            personasAsignadasRow.setFechaNacimiento(personaAsignada.getFechaNacimiento());
            personasAsignadasRow.setGrupoReferencia(personaAsignada.getGrupoReferencia());
            personasAsignadasRow.setObservacionesPersona(personaAsignada.getObservaciones());
        });

        return asistenteJornadaMaria;
    }

    @NotNull
    @Override
    public Action validarAsistenciaPersona() {
        if(getPersona() != null) {
            final AsistenteJornadaMaria asistenteJornadaMaria = findWhere(ASISTENTE_JORNADA_MARIA.PERSONA_ID.eq(getPersona().getId()));

            if (asistenteJornadaMaria != null) {
                return actions().getError().withMessage(asistenteJornadaMaria.getPersona().getNombre() + " " + asistenteJornadaMaria.getPersona().getApellido() + " ya se registró.");
            }
        }

        return updateMontoSugerido();
    }

    @NotNull
    @Override
    public Action validarAsistenciaEsposo() {
        if(getPersonaMatrimonio() != null){
            final AsistenteJornadaMaria asistenteJornadaMaria = findWhere(ASISTENTE_JORNADA_MARIA.PERSONA_ID.eq(getPersonaMatrimonio().getId()));

            if(asistenteJornadaMaria != null) {
                setPersonaMatrimonio(null);
                updateMontoSugerido();
                return actions().getError().withMessage(asistenteJornadaMaria.getPersona().getNombre() + " " + asistenteJornadaMaria.getPersona().getApellido() + " ya se registró.");
            }
        }

        return updateMontoSugerido();
    }

    @NotNull
    @Override
    public Action updateMontoSugerido() {
        double montoSugerido = getEvento().getMontoSoltero().doubleValue();

        if(isDefined(Field.PERSONA_MATRIMONIO) && getPersonaMatrimonio() != null)
            montoSugerido = getEvento().getMontoMatrimonio().doubleValue();

        setMontoSugerido(BigDecimal.valueOf(montoSugerido + calcularMontoHijos()));
        return actions().getDefault();
    }

    private double calcularMontoHijos() {
        final double montoNino = getEvento().getMontoNino().doubleValue();
        final double montoNinosDescuento = getEvento().getMontoNinosDescuento().doubleValue();

        if(getPersonasAsignadas().size() == 1)
            return montoNino;
        else if(getPersonasAsignadas().size() >= 2)
            return montoNino + (montoNinosDescuento * (getPersonasAsignadas().size() - 1));

        return 0;
    }

    @NotNull
    @Override
    public Action updateMontoSugeridoAfterRemove() {
        super.updateMontoSugeridoAfterRemove();
        return updateMontoSugerido();
    }

    public class PersonasAsignadasRow extends PersonasAsignadasRowBase {
        @NotNull
        @Override
        public Action updateEdad() {
            setEdad(String.valueOf(current().yearsFrom(getFechaNacimiento())) + " años");
            return actions().getDefault();
        }
    }
}
