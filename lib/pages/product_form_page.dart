import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/product.dart';

import '../models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  bool _isUpdate = false, _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product form"),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: _submitForm)],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        decoration: const InputDecoration(labelText: 'Name'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        validator: (value) {
                          final name = value?.trim() ?? '';
                          if (name.isEmpty) {
                            return 'Please enter a name';
                          }
                          if (name.length < 3) {
                            return 'Name must be at least 3 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['name'] = value ?? '',
                      ),
                      TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          final price = double.tryParse(value ?? '');
                          if (price == null || price <= 0) {
                            return 'Please enter a valid price';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          final price = double.tryParse(value ?? '');
                          if (price != null) {
                            _formData['price'] = price;
                          }
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration: const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        validator: (value) {
                          final description = value?.trim() ?? '';
                          if (description.isEmpty) {
                            return 'Please enter a description';
                          }
                          if (description.length < 10) {
                            return 'Description must be at least 10 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['description'] = value ?? '',
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Image URL'),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              onFieldSubmitted: (_) => _submitForm(),
                              validator: (value) {
                                final url = value ?? '';
                                if (url.isEmpty ||
                                    !url.startsWith('http') ||
                                    Uri.tryParse(url)?.hasAbsolutePath == false) {
                                  return 'Please enter a valid URL';
                                }
                                return null;
                              },
                              onSaved: (value) => _formData['imageUrl'] = value ?? '',
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(top: 8, left: 10),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                            child:
                                _imageUrlController.text.isEmpty
                                    ? const Center(child: Text("Preview"))
                                    : Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                        );
                                      },
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(onPressed: _submitForm, child: const Text('Save')),
                    ],
                  ),
                ),
              ),
    );
  }

  @override
  void initState() {
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context)?.settings.arguments as Product?;
      if (product != null) {
        _isUpdate = true;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;
        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  void _updateImageUrl() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    final product = Product.fromJson(_formData);
    final provider = Provider.of<ProductList>(context, listen: false);
    Future result = Future.value();

    if (_isUpdate) {
      result = provider.updateProduct(product);
    } else {
      result = provider.addProduct(product);
    }

    result
        .then((response) {
          if (!mounted) {
            return;
          }
          setState(() => _isLoading = false);
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('Product saved successfully!'), duration: const Duration(seconds: 2)),
          );
        })
        .catchError((onError) {
          setState(() => _isLoading = false);
          AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to save product: $onError. Please try again later.'),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          );
        });
  }
}
