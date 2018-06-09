package com.mopal.view;

import com.mopal.model.*;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.core.Option;
import tekgenesis.form.Action;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.MappingCallback;
import tekgenesis.persistence.Criteria;

import static com.mopal.core.NivelHelper.getNivelNinguno;
import static com.mopal.model.TipoEvento.ASAMBLEA;
import static com.mopal.model.g.AsistenteAsambleaBase.find;
import static com.mopal.model.g.AsistenteAsambleaBase.listWhere;
import static com.mopal.model.g.AsistenteAsambleaTable.ASISTENTE_ASAMBLEA;
import static com.mopal.model.g.AsistenteTable.ASISTENTE;
import static com.mopal.model.g.EventoBase.findWhere;
import static com.mopal.model.g.EventoTable.EVENTO;
import static tekgenesis.common.core.DateOnly.current;
import static tekgenesis.common.core.Option.option;

/** User class for form: AsistenteAsambleaFormListing */
public class AsistenteAsambleaFormListing extends AsistenteAsambleaFormListingBase {
    //~ Methods ..................................................................................................................
    final static Evento evento = findWhere(EVENTO.ACTIVO.eq(true).and(EVENTO.TIPO_EVENTO.eq(ASAMBLEA)));

    private Evento getEvento() {
        return evento;
    }

    @Override
    public void load() {
        super.load();
        setDescripcionEvento(getEvento().getDescripcion());
    }

    public void buscar(final Integer idEvento, final Integer idAsistente) {
        getAsistentesAsamblea().clear();
        getAsistentesAsamblea().add().populate(find(idEvento, idAsistente));
        setTotalRows("");
    }

    /** Invoked when button(buscar) is clicked */
    @Override @NotNull public Action buscar() {
        getAsistentesAsamblea().clear();

        final ImmutableList<AsistenteAsamblea> result = obtenerAsistentesFiltro(option(getNombreFiltro()), option(getApellidoFiltro()), option(getLocalidadFiltro()), option(getNivelFiltro()), option(getComunidadFiltro()));
        result.forEach(
                persona -> getAsistentesAsamblea().add().populate(persona)
        );

        setTotalRows(String.valueOf(result.getSize().getOrFail("0")));

        return actions.getDefault();
    }

    private Boolean isFilterPresent() {
        return option(getNombreFiltro()).isPresent() || option(getApellidoFiltro()).isPresent() || option(getLocalidadFiltro()).isPresent() || option(getNivelFiltro()).isPresent()|| option(getComunidadFiltro()).isPresent();
    }

    private ImmutableList<AsistenteAsamblea> obtenerAsistentesFiltro(final Option<String> nombre, final Option<String> apellido, final Option<Localidad> localidad, final Option<Nivel> nivel, final Option<Comunidad> comunidad) {
        final Criteria eventoCriteria = EVENTO.ID.eq(getEvento().getId());
        final Criteria nombreCriteria = nombre.isPresent() ? ASISTENTE.NOMBRE.contains(nombre.get()) : Criteria.EMPTY;
        final Criteria apellidoCriteria = apellido.isPresent() ? ASISTENTE.APELLIDO.contains(apellido.get()) : Criteria.EMPTY;
        final Criteria localidadCriteria = localidad.isPresent() ? ASISTENTE.LOCALIDAD_ID.eq(localidad.get().getId()) : Criteria.EMPTY;
        final Criteria nivelCriteria = nivel.isPresent() ? ASISTENTE.NIVEL_ID.eq(nivel.get().getId()) : Criteria.EMPTY;
        final Criteria comunidadCriteria = comunidad.isPresent() && nivel.isPresent() && !nivel.get().equals(getNivelNinguno()) ? ASISTENTE.COMUNIDAD_ID.eq(comunidad.get().getId()) : Criteria.EMPTY;

        return listWhere(eventoCriteria.and(nombreCriteria.and(apellidoCriteria.and(localidadCriteria.and(nivelCriteria).and(comunidadCriteria)))))
                .join(EVENTO, ASISTENTE_ASAMBLEA.EVENTO_ID.eq(EVENTO.ID))
                .join(ASISTENTE, ASISTENTE_ASAMBLEA.PERSONA_ID.eq(ASISTENTE.ID))
                .orderBy(ASISTENTE.APELLIDO, ASISTENTE.NOMBRE)
                .toList();
    }

    /** Invoked when button(resetear) is clicked */
    @Override @NotNull public Action resetearFiltros() {
        getAsistentesAsamblea().clear();
        loadAsistentes();
        return actions.getStay();
    }

    @NotNull
    @Override
    public Action addAsistencia() {
        final AsistenteAsambleaForm form = forms.initialize(AsistenteAsambleaForm.class);
        form.setEvento(getEvento());
        form.setForCreation(true);
        return actions().navigate(form).callback(AsistenciaFormMapping.class);
    }

    public class AsistentesAsambleaRow extends AsistentesAsambleaRowBase {
        @Override
        public void populate(@NotNull AsistenteAsamblea asistenteAsamblea) {
            super.populate(asistenteAsamblea);
            setIdEvento(asistenteAsamblea.getEvento().getId());
            setIdPersona(asistenteAsamblea.getPersona().getId());
            setNombre(asistenteAsamblea.getPersona().getNombre());
            setApellido(asistenteAsamblea.getPersona().getApellido());
            setEdad(String.valueOf(current().yearsFrom(asistenteAsamblea.getPersona().getFechaNacimiento())) + " años");
            setNivel(asistenteAsamblea.getPersona().getNivel());
            setComunidad(asistenteAsamblea.getPersona().getComunidad());
            setTelefono(asistenteAsamblea.getPersona().getTelefonoDeContacto());
            setPersonasACargo(asistenteAsamblea.getPersonasRelacionadas().size());
        }

        @NotNull
        @Override
        public Action editarPersona() {
            final AsistentesAsambleaRow current = getAsistentesAsamblea().getCurrent();
            return actions().navigate(AsistenteForm.class, String.valueOf(current.getIdPersona())).callback(PersonaFormMapping.class);

        }

        @NotNull
        @Override
        public Action editarAsistencia() {
            final AsistentesAsambleaRow current = getAsistentesAsamblea().getCurrent();
            final AsistenteAsamblea asistenteAsamblea = find(getEvento().getId(), current.getIdPersona());
            return actions().navigate(AsistenteAsambleaForm.class, asistenteAsamblea.keyAsString()).callback(AsistenciaFormMapping.class);
        }
    }

    @Override
    public void loadAsistentes() {
        buscar();
    }

    public static class PersonaFormMapping implements MappingCallback<AsistenteForm, AsistenteAsambleaFormListing> {
        @Override
        public void onSave(@NotNull AsistenteForm base, @NotNull AsistenteAsambleaFormListing out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentesAsamblea().clear();
                out.loadAsistentes();
            }
        }
    }

    public static class AsistenciaFormMapping implements MappingCallback<AsistenteAsambleaForm, AsistenteAsambleaFormListing> {
        @Override
        public void onDelete(@NotNull AsistenteAsambleaForm base, @NotNull AsistenteAsambleaFormListing out) {
            search(out);
        }

        @Override
        public void onSave(@NotNull AsistenteAsambleaForm base, @NotNull AsistenteAsambleaFormListing out) {
            if(base.isForCreation()) {
                out.buscar(base.getEvento().getId(), base.getPersona().getId());
            } else {
                search(out);
            }
        }

        private void search(final AsistenteAsambleaFormListing out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentesAsamblea().clear();
                out.loadAsistentes();
            }
        }
    }
}
