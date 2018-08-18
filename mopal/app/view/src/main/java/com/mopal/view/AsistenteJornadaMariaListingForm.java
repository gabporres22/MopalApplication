package com.mopal.view;


import com.mopal.model.*;
import org.jetbrains.annotations.NotNull;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.core.Option;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;
import tekgenesis.persistence.Criteria;

import java.math.BigDecimal;

import static com.mopal.core.NivelHelper.getNivelNinguno;
import static com.mopal.model.TipoEvento.JORNADA_MARIA;
import static com.mopal.model.g.AsistenteJornadaMariaBase.listWhere;
import static com.mopal.model.g.AsistenteJornadaMariaTable.ASISTENTE_JORNADA_MARIA;
import static com.mopal.model.g.AsistenteTable.ASISTENTE;
import static com.mopal.model.g.EventoBase.findWhere;
import static com.mopal.model.g.EventoTable.EVENTO;
import static tekgenesis.common.core.DateOnly.current;
import static tekgenesis.common.core.Option.option;

/** User class for form: AsistenteJornadaMariaListingForm */
public class AsistenteJornadaMariaListingForm extends AsistenteJornadaMariaListingFormBase {
    //~ Methods ..................................................................................................................
    final static Evento evento = findWhere(EVENTO.ACTIVO.eq(true).and(EVENTO.TIPO_EVENTO.eq(JORNADA_MARIA)));

    private Evento getEvento() {
        return evento;
    }

    @Override
    public void load() {
        super.load();
        setDescripcionEvento(getEvento().getDescripcion());
    }

    public void buscar(final Integer idEvento, final Integer idAsistente) {
        getAsistentesJornadaMaria().clear();
        getAsistentesJornadaMaria().add().populate(AsistenteJornadaMaria.find(idAsistente));
        setTotalRows("");
    }

    private ImmutableList<AsistenteJornadaMaria> obtenerAsistentesFiltro(final Option<String> nombre, final Option<String> apellido, final Option<Localidad> localidad, final Option<Nivel> nivel, final Option<Comunidad> comunidad) {
        final Criteria eventoCriteria = EVENTO.ID.eq(getEvento().getId());
        final Criteria nombreCriteria = nombre.isPresent() ? ASISTENTE.NOMBRE.contains(nombre.get()) : Criteria.EMPTY;
        final Criteria apellidoCriteria = apellido.isPresent() ? ASISTENTE.APELLIDO.contains(apellido.get()) : Criteria.EMPTY;
        final Criteria localidadCriteria = localidad.isPresent() ? ASISTENTE.LOCALIDAD_ID.eq(localidad.get().getId()) : Criteria.EMPTY;
        final Criteria nivelCriteria = nivel.isPresent() ? ASISTENTE.NIVEL_ID.eq(nivel.get().getId()) : Criteria.EMPTY;
        final Criteria comunidadCriteria = comunidad.isPresent() && nivel.isPresent() && !nivel.get().equals(getNivelNinguno()) ? ASISTENTE.COMUNIDAD_ID.eq(comunidad.get().getId()) : Criteria.EMPTY;

        return listWhere(eventoCriteria.and(nombreCriteria.and(apellidoCriteria.and(localidadCriteria.and(nivelCriteria).and(comunidadCriteria)))))
                .join(EVENTO, ASISTENTE_JORNADA_MARIA.EVENTO_ID.eq(EVENTO.ID))
                .join(ASISTENTE, ASISTENTE_JORNADA_MARIA.PERSONA_ID.eq(ASISTENTE.ID))
                .orderBy(ASISTENTE.APELLIDO, ASISTENTE.NOMBRE)
                .toList();
    }

    @NotNull
    @Override
    public Action buscar() {
        getAsistentesJornadaMaria().clear();

        final ImmutableList<AsistenteJornadaMaria> result = obtenerAsistentesFiltro(option(getNombreFiltro()), option(getApellidoFiltro()), option(getLocalidadFiltro()), option(getNivelFiltro()), option(getComunidadFiltro()));
        result.forEach(
            persona -> getAsistentesJornadaMaria().add().populate(persona)
        );

        setTotalRows(String.valueOf(result.getSize().getOrFail("0")));

        return actions.getDefault();
    }

    @NotNull
    @Override
    public Action resetearFiltros() {
        getAsistentesJornadaMaria().clear();
        loadAsistentes();
        return actions.getStay();
    }

    @NotNull
    @Override
    public Action addAsistencia() {
        final AsistenteJornadaMariaForm form = forms.initialize(AsistenteJornadaMariaForm.class);
        form.setEvento(getEvento());
        form.setForCreation(true);
        return actions().navigate(form).callback(AsistenciaFormMapping.class);
    }

    @Override
    public void loadAsistentes() {
        super.loadAsistentes();
    }

    private Boolean isFilterPresent() {
        return option(getNombreFiltro()).isPresent() || option(getApellidoFiltro()).isPresent() || option(getLocalidadFiltro()).isPresent() || option(getNivelFiltro()).isPresent()|| option(getComunidadFiltro()).isPresent();
    }

    public class AsistentesJornadaMariaRow extends AsistentesJornadaMariaRowBase {
        @Override
        public void populate(@NotNull AsistenteJornadaMaria asistenteJornadaMaria) {
            super.populate(asistenteJornadaMaria);
            setId(asistenteJornadaMaria.getId());
            setIdEvento(asistenteJornadaMaria.getEvento().getId());
            setIdPersona(asistenteJornadaMaria.getPersona().getId());
            setNombre(asistenteJornadaMaria.getPersona().getNombre());
            setApellido(asistenteJornadaMaria.getPersona().getApellido());
            setEdad(String.valueOf(current().yearsFrom(asistenteJornadaMaria.getPersona().getFechaNacimiento())) + " años");
            setNivel(asistenteJornadaMaria.getPersona().getNivel());
            setComunidad(asistenteJornadaMaria.getPersona().getComunidad());
            setTelefono(asistenteJornadaMaria.getPersona().getTelefonoDeContacto());
            setContribucion(asistenteJornadaMaria.getMontoContribucion().compareTo(BigDecimal.ZERO) > 0);
            setPersonasACargo(asistenteJornadaMaria.getPersonasRelacionadas().size());
        }

        @NotNull
        @Override
        public Action editarPersona() {
            final AsistentesJornadaMariaRow current = getAsistentesJornadaMaria().getCurrent();
            return actions().navigate(AsistenteForm.class, String.valueOf(current.getIdPersona())).callback(PersonaFormMapping.class);
        }

        @NotNull
        @Override
        public Action editarAsistencia() {
            final AsistentesJornadaMariaRow current = getAsistentesJornadaMaria().getCurrent();
            final AsistenteJornadaMaria asistenteJornadaMaria = AsistenteJornadaMaria.find(current.getId());
            final AsistenteJornadaMariaForm form = forms.initialize(AsistenteJornadaMariaForm.class, String.valueOf(asistenteJornadaMaria.getId()));
            form.setForUpdate(true);
            return actions().navigate(form).callback(AsistenciaFormMapping.class);
        }
    }

    public static class PersonaFormMapping implements MappingCallback<AsistenteForm, AsistenteJornadaMariaListingForm> {
        @Override
        public void onSave(@NotNull AsistenteForm base, @NotNull AsistenteJornadaMariaListingForm out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentesJornadaMaria().clear();
                out.loadAsistentes();
            }
        }
    }

    public static class AsistenciaFormMapping implements MappingCallback<AsistenteJornadaMariaForm, AsistenteJornadaMariaListingForm> {
        @Override
        public void onDelete(@NotNull AsistenteJornadaMariaForm base, @NotNull AsistenteJornadaMariaListingForm out) {
            out.getAsistentesJornadaMaria().clear();
            out.loadAsistentes();
        }

        @Override
        public void onSave(@NotNull AsistenteJornadaMariaForm base, @NotNull AsistenteJornadaMariaListingForm out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentesJornadaMaria().clear();
                out.loadAsistentes();
            }
        }
    }
}
