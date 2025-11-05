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
