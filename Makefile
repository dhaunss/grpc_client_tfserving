
#adapted from https://medium.com/@andrewvetovitz/grpc-c-introduction-45a66ca9461f

LDFLAGS = -L/usr/local/lib `pkg-config --libs protobuf grpc++`\
           -Wl,--no-as-needed -lgrpc++_reflection -Wl,--as-needed\
           -ldl

CXX = g++
CPPFLAGS += `pkg-config --cflags protobuf grpc`
CXXFLAGS += -std=c++11

GRPC_CPP_PLUGIN = grpc_cpp_plugin
GRPC_CPP_PLUGIN_PATH ?= `which $(GRPC_CPP_PLUGIN)`

all: predict

predict: types.pb.o types.grpc.pb.o tensor_shape.pb.o tensor_shape.grpc.pb.o resource_handle.pb.o resource_handle.grpc.pb.o model.pb.o model.grpc.pb.o tensor.pb.o tensor.grpc.pb.o predict.pb.o predict.grpc.pb.o prediction_service.pb.o prediction_service.grpc.pb.o predict.o
	$(CXX) $^ $(LDFLAGS) -o $@


clean:
	rm -f *.o *.pb.cc *.pb.h client server