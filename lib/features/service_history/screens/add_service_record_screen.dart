import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/service_history/logic/service_history_cubit.dart';
import 'package:flutter_practice10/features/vehicles/logic/vehicles_cubit.dart';
import 'package:go_router/go_router.dart';

class AddServiceRecordScreen extends StatefulWidget {
  const AddServiceRecordScreen({super.key});

  @override
  State<AddServiceRecordScreen> createState() => _AddServiceRecordScreenState();
}

class _AddServiceRecordScreenState extends State<AddServiceRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _costController = TextEditingController();

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final activeVehicle = context.read<VehiclesCubit>().state.activeVehicle;
      if (activeVehicle == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Нет активного автомобиля')),
        );
        return;
      }
      final title = _titleController.text;
      final cost = double.tryParse(_costController.text) ?? 0.0;
      context.read<ServiceHistoryCubit>().addServiceRecord(activeVehicle.id, title, cost);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: "https://cdn-icons-png.flaticon.com/512/189/189715.png",
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text('Добавить запись о ТО'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста введите название';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Стоимость',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста введите стоимость';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Сохранить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

