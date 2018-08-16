package com.mopal.view;

import com.mopal.model.EstadoCivil;
import com.mopal.model.PRJornadaMaria;
import tekgenesis.form.Action;
import com.mopal.model.AsistenteJornadaMaria;
import org.jetbrains.annotations.NotNull;

import java.math.BigDecimal;

import static java.math.BigDecimal.ZERO;
import static tekgenesis.common.core.DateOnly.current;

/** User class for form: AsistenteJornadaMariaForm */
public class AsistenteJornadaMariaForm extends AsistenteJornadaMariaFormBase {
    //~ Methods ..................................................................................................................

    /** Invoked when creating a form instance */
    @Override @NotNull public Action create() {
        final AsistenteJornadaMaria asistenteJornadaMaria = AsistenteJornadaMaria.create(getEvento().getId(), getPersona().getId());
        asistenteJornadaMaria.setObservaciones(getObservaciones());

        if(getPersonaMatrimonio() == null) {
            if(!getMontoSugerido().equals(getMontoContribucion()) || getMontoContribucion().equals(ZERO)) {
                asistenteJornadaMaria.setMontoContribucion(getMontoContribucion());
            } else {
                asistenteJornadaMaria.setMontoContribucion(getEvento().getMontoSoltero().add(BigDecimal.valueOf(calcularMontoHijos())));
            }
        } else {
            double montoContribucion = 0;

            if(!getMontoSugerido().equals(getMontoContribucion()) || getMontoContribucion().equals(ZERO)) {
                montoContribucion = getMontoContribucion().divide(BigDecimal.valueOf(2)).doubleValue();
            } else {
                montoContribucion = getEvento().getMontoMatrimonio().add(BigDecimal.valueOf(calcularMontoHijos())).divide(BigDecimal.valueOf(2)).doubleValue();
            }

            asistenteJornadaMaria.setMontoContribucion(BigDecimal.valueOf(montoContribucion));

            final AsistenteJornadaMaria asistenteJornadaMariaEsposo = AsistenteJornadaMaria.create(getEvento().getId(), getPersonaMatrimonio().getId());
            asistenteJornadaMariaEsposo.setObservaciones(getObservaciones());
            asistenteJornadaMariaEsposo.setMontoContribucion(BigDecimal.valueOf(montoContribucion));
            asistenteJornadaMariaEsposo.insert();
        }

        final AsistenteJornadaMaria asistenteJornadaMariaNew = asistenteJornadaMaria.insert();

        if(getPersonasAsignadas().size() > 0) {
            getPersonasAsignadas().forEach(item -> {
                final PRJornadaMaria personaRelacionadaJornadaMaria = PRJornadaMaria.create();

                personaRelacionadaJornadaMaria.setPersonaRelacionada(asistenteJornadaMariaNew);
                personaRelacionadaJornadaMaria.setNombre(item.getNombre());
                personaRelacionadaJornadaMaria.setApellido(item.getApellido());
                personaRelacionadaJornadaMaria.setFechaNacimiento(item.getFechaNacimiento());
                personaRelacionadaJornadaMaria.setGrupoReferencia(item.getGrupoReferencia());
                personaRelacionadaJornadaMaria.setObservaciones(item.getObservacionesPersona());

                personaRelacionadaJornadaMaria.insert();
            });
        }

        return actions().getDefault();
    }

    @NotNull
    @Override
    public Action update() {
        return super.update();
    }

    /** Invoked to find an entity instance */
    @Override @NotNull public AsistenteJornadaMaria find() {
        throw new IllegalStateException("To be implemented");
    }

    @NotNull
    @Override
    public Action validarAsistenciaPersona() {
        if(getPersona() != null) {
            final AsistenteJornadaMaria asistenteJornadaMaria = AsistenteJornadaMaria.find(getEvento().getId(), getPersona().getId());

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
            final AsistenteJornadaMaria asistenteJornadaMaria = AsistenteJornadaMaria.find(getEvento().getId(), getPersonaMatrimonio().getId());

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
        if(getPersonasAsignadas().size() == 1)
            return getEvento().getMontoNiño().doubleValue();
        else if(getPersonasAsignadas().size() >= 2)
            return getEvento().getMontoNiñosDescuento().multiply(BigDecimal.valueOf(getPersonasAsignadas().size() - 1)).doubleValue();

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
