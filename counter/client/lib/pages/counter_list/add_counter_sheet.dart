import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/alert_dialog.dart';
import 'view_model.dart';

class AddCounterSheet extends StatefulWidget {
  const AddCounterSheet({super.key, required this.model});

  final CounterListViewModel model;
  @override
  State<AddCounterSheet> createState() => _AddCounterSheetState();
}

class _AddCounterSheetState extends State<AddCounterSheet> {
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  var _isNameEmpty = true;
  var _isValueEmpty = true;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _isNameEmpty = _nameController.text.isEmpty;
      });
    });
    _valueController.addListener(() {
      setState(() {
        _isValueEmpty = _valueController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  var _isLoading = false;

  void _onConfirm() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.model.addCounter(
        _nameController.text,
        int.tryParse(_valueController.text) ?? 0,
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        showAlertDialog(
          context,
          title: 'Failed to add a counter',
          message: '$e',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create counter',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valueController,
            decoration: const InputDecoration(
              labelText: 'Value',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isNameEmpty || _isValueEmpty || _isLoading
                    ? null
                    : _onConfirm,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Confirm'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
