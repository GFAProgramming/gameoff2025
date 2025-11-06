class_name NullableTest
extends GdUnitTestSuite

@warning_ignore_start("UNUSED_PARAMETER")
@warning_ignore_start("REDUNDANT_AWAIT")

const __source: String = 'res://src/types/nullable.gd'

func test__init_with_permitted_types(value: Variant, type: Variant.Type, test_parameters := [
	[null, Variant.Type.TYPE_INT],
	[100, Variant.Type.TYPE_INT],
	[[], Variant.Type.TYPE_ARRAY],
	[null, Variant.Type.TYPE_ARRAY]
]) -> void:
	var nullable: Nullable = auto_free(Nullable.new(value, type))
	
	assert_that(nullable.get_value()).is_equal(value)
	assert_that(nullable._permitted_type).is_equal(type)

func test__init_with_unpermitted_types(value: Variant, type: Variant.Type, test_parameters := [
	[100, Variant.Type.TYPE_FLOAT],
	[[], Variant.Type.TYPE_DICTIONARY]
]) -> void:
	await assert_error(func():
		var nullable: Nullable = auto_free(Nullable.new(value, type))
		assert_object(nullable.get_value().is_null()
	).is_push_error("%s is not a one of the legal variant types." % typeof(value)))

func test_get_value(value: Variant, type: Variant.Type, test_parameters := [
	[null, Variant.Type.TYPE_INT],
	[100, Variant.Type.TYPE_INT]
]) -> void:
	var nullable: Nullable = auto_free(Nullable.new(value, type))
	assert_object(nullable.get_value()).is_equal(value)
	
func test_set_value_with_permitted_type() -> void:
	var value: int = 200
	var nullable: Nullable = auto_free(Nullable.new(100, Variant.Type.TYPE_INT))
	
	nullable.set_value(value)
	assert_object(nullable._value_or_null._value).is_equal(value)

func test_set_value_with_unpermitted_type() -> void:
	var permitted_value = 100
	var unpermitted_value: Array[float] = []
	var nullable: Nullable = auto_free(Nullable.new(permitted_value, Variant.Type.TYPE_INT))
	
	await assert_error(func():
		nullable.set_value(unpermitted_value)
		assert_int(nullable.get_value()).is_equal(permitted_value)
	).is_push_error("Illegal assignment of type Array to Nullable[int]")
