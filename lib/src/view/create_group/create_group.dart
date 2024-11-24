import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PageCreateGroup extends HookWidget {
  const PageCreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final groupService = locator<GroupService>();
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final imageUrlController = useTextEditingController();
    final tagsController = useTextEditingController();

    final isSubmitting = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    Future<void> submitForm() async {
      if (!formKey.currentState!.validate()) return;

      final title = titleController.text.trim();
      final description = descriptionController.text.trim();
      //TODO CLEM use widget/ImageSelector instead
      final imageUrl = imageUrlController.text.trim();
      final tags = tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList();

      // Trigger loading state
      isSubmitting.value = true;

      try {
        await groupService.addGroup(title, description, imageUrl, tags);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group added successfully!')),
        );
        // Clear the form
        titleController.clear();
        descriptionController.clear();
        imageUrlController.clear();
        tagsController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding group: $e')),
        );
      } finally {
        isSubmitting.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add Group')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Description is required'
                    : null,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Image URL is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags (comma-separated)',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isSubmitting.value ? null : submitForm,
                child: isSubmitting.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
