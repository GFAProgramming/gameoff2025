class_name UnionTest
extends GdUnitTestSuite

@warning_ignore_start("REDUNDANT_AWAIT")
@warning_ignore_start("UNUSED_PARAMETER")

const __source: String = 'res://src/types/Union.gd'

func test__init() -> void:
	var value: int = 100
	var permitted_types: Array[Variant.Type] = [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]
	var union: Union = auto_free(Union.new(value, permitted_types))
	
	assert_that(typeof(union.get_value())).is_equal(Variant.Type.TYPE_INT)
	
	assert_int(union.get_value()).is_equal(value)
	assert_array(union._permitted_types).is_equal(permitted_types)

func test__validate_variant_type_with_unpermitted_types(value: Variant, permitted_types: Array[Variant.Type], test_parameters := [
	[null, [Variant.Type.TYPE_INT, Variant.Type.TYPE_FLOAT]],
	[100.0, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
	[{}, [Variant.Type.TYPE_INT, Variant.Type.TYPE_ARRAY]]
]) -> void:
	await assert_error(func():
		var union: Union = Union.new(value, permitted_types)
		var error: Error = union._validate_variant_type(value)
		
		assert_that(error).equals(Error.ERR_INVALID_PARAMETER)
	).is_push_error("%s is not a one of the legal variant types." % typeof(value))
	
func test__validate_variant_type_with_permitted_types(value: Variant, permitted_types: Array[Variant.Type], test_parameters := [
	[null, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
	[100, [Variant.Type.TYPE_INT, Variant.Type.TYPE_NIL]],
	[[], [Variant.Type.TYPE_ARRAY]]
]) -> void:
		var union: Union = Union.new(value, permitted_types)
		var error: Error = union._validate_variant_type(value)
		
		assert_that(error).equals(Error.OK)

func test_is_null(value: Variant, expected_is_null: bool, test_parameters := [
	[null, true],
	[100, false],
	[[], false]
]) -> void:
	var permitted_types: Array[Variant.Type] = [Variant.Type.TYPE_NIL, Variant.Type.TYPE_INT, Variant.Type.TYPE_ARRAY]
	var union: Union = auto_free(Union.new(value, permitted_types))

	var actual_is_null: bool = union.is_null()
	assert_bool(actual_is_null).is_equal(expected_is_null)
