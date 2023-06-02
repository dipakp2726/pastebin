// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileSubmitHash() => r'b117fd43ac4e172bee28d0cd6b107d03d8ee14b3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef ProfileSubmitRef = AutoDisposeFutureProviderRef<dynamic>;

/// See also [profileSubmit].
@ProviderFor(profileSubmit)
const profileSubmitProvider = ProfileSubmitFamily();

/// See also [profileSubmit].
class ProfileSubmitFamily extends Family<AsyncValue<dynamic>> {
  /// See also [profileSubmit].
  const ProfileSubmitFamily();

  /// See also [profileSubmit].
  ProfileSubmitProvider call({
    required String name,
    required String email,
  }) {
    return ProfileSubmitProvider(
      name: name,
      email: email,
    );
  }

  @override
  ProfileSubmitProvider getProviderOverride(
    covariant ProfileSubmitProvider provider,
  ) {
    return call(
      name: provider.name,
      email: provider.email,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'profileSubmitProvider';
}

/// See also [profileSubmit].
class ProfileSubmitProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [profileSubmit].
  ProfileSubmitProvider({
    required this.name,
    required this.email,
  }) : super.internal(
          (ref) => profileSubmit(
            ref,
            name: name,
            email: email,
          ),
          from: profileSubmitProvider,
          name: r'profileSubmitProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$profileSubmitHash,
          dependencies: ProfileSubmitFamily._dependencies,
          allTransitiveDependencies:
              ProfileSubmitFamily._allTransitiveDependencies,
        );

  final String name;
  final String email;

  @override
  bool operator ==(Object other) {
    return other is ProfileSubmitProvider &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
