class_name UnionTest
extends GdUnitTestSuite

@warning_ignore_start("REDUNDANT_AWAIT")
@warning_ignore_start("UNUSED_PARAMETER")

const __source: String = 'res://src/types/Union.gd'
		
## get_value() should return the underlying Variant value
func test_get_value(value: Variant, permitted_types: Array[Variant.Type], test_parameters := [
	[100, [Variant.Type.TYPE_INT, Variant.Type.TYPE_FLOAT]],
	[{}, [Variant.Type.TYPE_NIL, Variant.Type.TYPE_DICTIONARY]],
]) -> void:
	var union: Union = auto_free(Union.new(value, permitted_types))
	
	assert_object(typeof(union.value)).is_equal(typeof(value))
	assert_object(union.value).is_equal(value)

## permits_assignment_of_type() should return true if and only if the the type of the 
## value parameter is one of the types the Union was permitted to allow on construction
func test_permits_assignment_of_type(value: Variant, type: Variant.Type, permitted_types: Array[Variant.Type], test_parameters := [
	[100, Variant.Type.TYPE_INT, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
	[100, Variant.Type.TYPE_NIL, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
	[[], Variant.Type.TYPE_ARRAY, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
]) -> void:
	var union: Union = auto_free(Union.new(value, permitted_types))
	assert_bool(union.permits_assignment_of_type(type)).is_true()

## is_null() should return true if and only if the type of the current value is Variant.Type.TYPE_NIL
func test_is_null(value: Variant, expected_is_null: bool, test_parameters := [
	[null, true],
	[100, false],
	[[], false]
]) -> void:
	var permitted_types: Array[Variant.Type] = [Variant.Type.TYPE_NIL, Variant.Type.TYPE_INT, Variant.Type.TYPE_ARRAY]
	var union: Union = auto_free(Union.new(value, permitted_types))

	var actual_is_null: bool = union.is_null()
	assert_bool(actual_is_null).is_equal(expected_is_null)

## _init() should correctly initialize fields in the correct order
func test__init() -> void:
	var value: int = 100
	var permitted_types: Array[Variant.Type] = [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]
	var union: Union = auto_free(Union.new(value, permitted_types))
	
	assert_that(typeof(union.get_value())).is_equal(Variant.Type.TYPE_INT)
	
	assert_int(union.get_value()).is_equal(value)
	assert_array(union._permitted_types).is_equal(permitted_types)

## Constructing a Union with an illegal value should default-construct it with null
func test__validate_type_with_unpermitted_types(value: Variant, permitted_types: Array[Variant.Type], test_parameters := [
	[null, [Variant.Type.TYPE_INT, Variant.Type.TYPE_FLOAT]],
	[100.0, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
	[{}, [Variant.Type.TYPE_INT, Variant.Type.TYPE_ARRAY]]
]) -> void:
	await assert_error(func():
		var union: Union = Union.new(value, permitted_types)
		var error: Error = union._validate_variant_type(value)
		
		assert_that(error).equals(Error.ERR_INVALID_PARAMETER)
	).is_push_error("%s is not one of the legal variant types." % typeof(value))
	
func test__validate_type_with_permitted_types(value: Variant, permitted_types: Array[Variant.Type], test_parameters := [
	[null, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
	[100, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
	[[], [Variant.Type.TYPE_ARRAY]]
]) -> void:
	var union: Union = Union.new(value, permitted_types)
	var error: Error = union._validate_variant_type(value)
	
	assert_that(error).equals(Error.OK)
