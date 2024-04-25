part of 'ncf_cubit.dart';

@freezed
class NcfState with _$NcfState {
  const factory NcfState.initial() = _Initial;
  const factory NcfState.loading() = _Loading;
  const factory NcfState.loaded(List<NcfType> ncfTypes) = _Loaded;
  const factory NcfState.error(String message) = _Error;
}
