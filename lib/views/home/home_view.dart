import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reltm_crud/views/add_item/add_item_view.dart';
import 'package:reltm_crud/views/home/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Items'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemView()),
          );
        },
        label: const Text('Add Item +'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return Center(
        child: Text(
          'Error: ${viewModel.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (viewModel.items.isEmpty) {
      return const Center(
        child: Text('No items found. Click add to create one.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: viewModel.items.length,
      itemBuilder: (context, index) {
        final item = viewModel.items[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            title: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Quantity: ${item.quantity}'),
                Text(
                  item.isbought ? 'Status: Bought' : 'Status: Pending',
                  style: TextStyle(
                    color: item.isbought ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // TODO: Implement Edit
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // TODO: Implement Delete
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
